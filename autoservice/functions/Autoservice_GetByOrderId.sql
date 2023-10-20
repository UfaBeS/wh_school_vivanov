CREATE OR REPLACE FUNCTION autoservice.autoservice_getbyorderid(_order_id BIGINT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT o.order_id,
                     o.order_date,
                     o.service_id,
                     p.service_name,
                     o.vehicle_id,
                     c.name,
                     c.phone,
                     v.vin,
                     o.status,
                     o.appointment,
                     o.problem,
                     o.is_actual
              FROM autoservice.orders o
                       INNER JOIN autoservice.prices p ON o.service_id = p.service_id
                       INNER JOIN customer.vehicles v ON o.vehicle_id = v.vehicle_id
                       INNER JOIN customer.customers c ON v.vehicle_id = c.vehicle_id
              WHERE o.order_id = _order_id) res;
END
$$;