CREATE OR REPLACE FUNCTION autoservice.autoservice_getbyorderid(_order_id BIGINT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT o.order_id     AS Айди_заказа,
                     o.order_date   AS Время_заказа,
                     o.service_id   AS Айди_услуги,
                     p.service_name AS Название,
                     o.vehicle_id   AS Айди_машины,
                     c.name         AS Владелец,
                     c.phone        AS Номер,
                     v.model        AS Модель,
                     v.vin          AS Vin,
                     v.year         AS Год,
                     o.status       AS Статус,
                     o.appointment  AS Запись,
                     o.problem      AS Проблема,
                     o.is_actual    AS Актуальность
              FROM autoservice.orders o
                       INNER JOIN autoservice.prices p ON o.service_id = p.service_id
                       INNER JOIN customer.vehicles v ON o.vehicle_id = v.vehicle_id
                       INNER JOIN customer.customers c ON v.vehicle_id = c.vehicle_id
              WHERE o.order_id = _order_id) res;
END
$$;