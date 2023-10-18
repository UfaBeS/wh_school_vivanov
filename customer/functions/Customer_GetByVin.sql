CREATE OR REPLACE FUNCTION customer.customer_getbyvin(_vin VARCHAR(17)) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (
SELECT c.customer_id AS Айди_клиента,
       c.name        AS Имя,
       c.phone       AS Номер,
       v.vehicle_id  AS Айди_машины,
       vb.name       AS Марка,
       vb.country    AS Страна,
       tc.name_type  AS Тип_машины
FROM customer.vehicles v
         LEFT JOIN customer.customers c on c.vehicle_id = v.vehicle_id
         INNER JOIN dictionary.vehiclebrands vb ON v.brand_id = vb.brand_id
         INNER JOIN dictionary.typescar tc ON v.type_car_id = tc.type_car_id
WHERE v.vin = _vin)
 res;
END
$$;