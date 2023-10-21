CREATE OR REPLACE FUNCTION autoservice.customers_getpricebycustomerid(_customer_id INT) RETURNS jsonb
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
                     o.service_id,
                     SUM(p.price)
              FROM customer.customers c
                       INNER JOIN autoservice.orders o on c.vehicle_id = o.vehicle_id
                       INNER JOIN autoservice.prices p on o.service_id = p.service_id
              WHERE c.customer_id = _customer_id
              GROUP BY c.customer_id,
                       c.name,
                       c.phone,
                       c.vehicle_id,
                       o.service_id) res;
END
$$;