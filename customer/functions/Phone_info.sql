CREATE OR REPLACE FUNCTION customer.phone_info(_phone VARCHAR(12)) RETURNS jsonb
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
              WHERE c.phone = _phone) res;
END
$$;