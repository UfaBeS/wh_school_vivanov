CREATE OR REPLACE FUNCTION history.customerchanges_createpartitions(start_date timestamptz, end_date timestamptz, table_name text) RETURNS VOID
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
DECLARE
    partition_name text;
    current_partition_date date := start_date;
BEGIN
    LOOP
        EXIT WHEN current_partition_date >= end_date;

        partition_name := table_name || '_' || to_char(current_partition_date, 'YYYYMM');

        EXECUTE 'CREATE TABLE IF NOT EXISTS history.' || partition_name ||
                ' PARTITION OF history.' || table_name ||
                ' FOR VALUES FROM (''' || current_partition_date || ''') TO (''' || (current_partition_date + INTERVAL '1 month') || ''')';

        current_partition_date := current_partition_date + INTERVAL '1 month';
    END LOOP;
END;
$$;
