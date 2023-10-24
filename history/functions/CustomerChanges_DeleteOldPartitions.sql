CREATE OR REPLACE FUNCTION history.customerchanges_deleteoldpartitions(_table_name TEXT) RETURNS VOID
LANGUAGE plpgsql
AS
$$
DECLARE
    _old_partition_name TEXT;
BEGIN
    FOR _old_partition_name IN
        (WITH get_partexp AS
                  (SELECT pt.relname                                 AS partition_name,
                          pg_get_expr(pt.relpartbound, pt.oid, true) AS partition_expression
                   FROM pg_class base_tb
                            JOIN pg_inherits i ON i.inhparent = base_tb.oid
                            JOIN pg_class pt ON pt.oid = i.inhrelid
                   WHERE base_tb.oid = concat('history.', _table_name)::regclass)
         SELECT partition_name
         FROM get_partexp
         WHERE substring(partition_expression FROM 'TO \(''(.*?)''\)')::TIMESTAMPTZ < NOW() - INTERVAL '90 days')
    LOOP
        RAISE NOTICE 'Выполняем: DROP TABLE IF EXISTS history.%', _table_name || '_' || _old_partition_name;
        EXECUTE 'DROP TABLE IF EXISTS history.' || _old_partition_name;
    END LOOP;
END;
$$;

