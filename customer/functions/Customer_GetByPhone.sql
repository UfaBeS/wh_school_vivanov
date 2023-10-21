CREATE OR REPLACE FUNCTION customer.customer_getbyphone(_phone VARCHAR(12) DEFAULT NULL) RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT c.customer_id,
                     c.name,
                     c.phone,
                     c.vehicle_id,
                     v.vin
              FROM customer.customers c
                       INNER JOIN customer.vehicles v on c.vehicle_id = v.vehicle_id
              WHERE c.phone = COALESCE(_phone, c.phone)) res;
END
$$;