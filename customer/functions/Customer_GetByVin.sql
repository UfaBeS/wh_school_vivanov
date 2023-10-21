CREATE OR REPLACE FUNCTION customer.customer_getbyvin(_vin VARCHAR(17) DEFAULT NULL) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT c.customer_id,
                     c.name,
                     c.phone,
                     v.vehicle_id,
                     v.vin,
                     vb.name,
                     vb.country,
                     tc.name_type
              FROM customer.vehicles v
                       LEFT JOIN customer.customers c ON c.vehicle_id = v.vehicle_id
                       INNER JOIN dictionary.vehiclebrands vb ON v.brand_id = vb.brand_id
                       INNER JOIN dictionary.typescar tc ON v.type_car_id = tc.type_car_id
              WHERE (_vin IS NULL OR v.vin = _vin)) res;
END
$$;
