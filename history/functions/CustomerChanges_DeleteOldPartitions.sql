CREATE OR REPLACE FUNCTION history.customerchanges_deleteoldpartitions() RETURNS void
    LANGUAGE plpgsql AS
$$
DECLARE
    old_partition_name text;
BEGIN
    FOR old_partition_name IN
        (WITH get_partexp AS
                  (select pt.relname                                 as partition_name,
                          pg_get_expr(pt.relpartbound, pt.oid, true) as partition_expression
                   from pg_class base_tb
                            join pg_inherits i on i.inhparent = base_tb.oid
                            join pg_class pt on pt.oid = i.inhrelid
                   where base_tb.oid = 'history.customerschanges'::regclass)
         select partition_name
         from get_partexp
         where substring(partition_expression FROM 'TO \(''(.*?)''\)')::timestamptz < NOW() - INTERVAL '90 days')
        LOOP
            RAISE NOTICE 'Выполняем: DROP TABLE IF EXISTS history.customerschanges_%', old_partition_name;
            EXECUTE 'DROP TABLE IF EXISTS history.' || old_partition_name;
        END LOOP;

END
$$;