CREATE OR REPLACE FUNCTION customer.vehicleid_info(_vehicle_id BIGINT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT c.customer_id AS Айди_клиента,
                     c.name        AS Имя,
                     c.phone       AS Номер
              FROM customer.customers c
              WHERE c.vehicle_id = _vehicle_id) res;
END
$$;