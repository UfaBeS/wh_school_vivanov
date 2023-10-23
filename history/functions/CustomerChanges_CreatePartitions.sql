CREATE OR REPLACE FUNCTION history.customerchanges_createpartitions(_start_date TIMESTAMPTZ, _end_date TIMESTAMPTZ, _table_name TEXT) RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS
$$
DECLARE
    _partition_name TEXT;
    _current_partition_date DATE := _start_date;
BEGIN
    LOOP
        EXIT WHEN _current_partition_date >= _end_date;

        _partition_name := _table_name || '_' || to_char(_current_partition_date, 'YYYYMM');

        EXECUTE 'CREATE TABLE IF NOT EXISTS history.' || _partition_name ||
                ' PARTITION OF history.' || _table_name ||
                ' FOR VALUES FROM (''' || _current_partition_date || ''') TO (''' || (_current_partition_date + INTERVAL '1 month') || ''')';

        _current_partition_date := _current_partition_date + INTERVAL '1 month';
    END LOOP;
END;
$$;
