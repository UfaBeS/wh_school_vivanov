CREATE OR REPLACE FUNCTION customer.vin_info(_vin VARCHAR(17)) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT c.customer_id AS Айди_клиента,
                     c.name        AS Имя,
                     c.phone       AS Номер,
                     c.vehicle_id  AS Айди_машины
              FROM customer.customers c
                       INNER JOIN customer.vehicles v on c.vehicle_id = v.vehicle_id
              WHERE v.vin = _vin) res;
END
$$;