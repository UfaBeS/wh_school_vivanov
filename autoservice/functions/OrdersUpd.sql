CREATE OR REPLACE FUNCTION autoservice.ordersupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _order_id    BIGINT;
    _order_date  TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
    _service_id  INT;
    _vehicle_id  BIGINT;
    _status      CHAR(3);
    _appointment TIMESTAMP;
    _problem     VARCHAR(500);
    _is_actual   BOOLEAN;
BEGIN
    SELECT coalesce(s.order_id, nextval('autoservice.autoservicesq')) AS order_id,
           s.service_id,
           s.vehicle_id,
           s.status,
           s.appointment,
           s.problem,
           s.is_actual
    INTO _order_id, _service_id, _vehicle_id, _status, _appointment, _problem, _is_actual
    FROM jsonb_to_record(_src) AS s (order_id BIGINT,
                                     service_id INT,
                                     vehicle_id BIGINT,
                                     status CHAR(3),
                                     appointment TIMESTAMP,
                                     problem VARCHAR(500),
                                     is_actual BOOLEAN);
    IF EXISTS (SELECT 1
               FROM autoservice.orders o
                        INNER JOIN autoservice.prices p on o.service_id = p.service_id
               WHERE _appointment BETWEEN (o.appointment) AND
                   (o.appointment + INTERVAL '1 hour' * p.work_time)
                  OR _appointment BETWEEN (o.appointment) AND
                         (o.appointment - INTERVAL '1 hour' * p.work_time)
                   AND o.is_actual = TRUE
                   AND o.status != 'rdy')
    THEN
        RETURN public.errmessage(_errcode := 'autoservice.order_time_is_busy',
                                 _msg := 'Данное время уже занято!',
                                 _detail := concat('order_id = ', _order_id, ' ', 'appointment = ', _appointment));
    END IF;

    UPDATE autoservice.stock
    SET quantity = quantity - 1
    WHERE detail_id IN (SELECT detail_id FROM dictionary.servicedetails WHERE service_id = _service_id)
      AND _status = 'prg'
      AND _is_actual = TRUE;

    INSERT INTO autoservice.orders (order_id,
                                    order_date,
                                    service_id,
                                    vehicle_id,
                                    status,
                                    appointment,
                                    problem,
                                    is_actual)
    SELECT _order_id,
           _order_date,
           _service_id,
           _vehicle_id,
           _status,
           _appointment,
           _problem,
           _is_actual
    ON CONFLICT (order_id) DO UPDATE
        SET service_id  = excluded.service_id,
            vehicle_id  = excluded.vehicle_id,
            status      = excluded.status,
            appointment = excluded.appointment,
            problem     = excluded.problem,
            is_actual   = excluded.is_actual;

    RETURN jsonb_build_object('data', NULL);
END
$$;