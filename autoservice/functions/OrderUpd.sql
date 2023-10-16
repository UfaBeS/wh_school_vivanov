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
    SET TIME ZONE 'Europe/Moscow';

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
                   (o.appointment + INTERVAL '1 hour' * p.work_time + INTERVAL '1 day' * ((p.work_time / 24)::INT))
                 OR _appointment BETWEEN (o.appointment) AND
                   (o.appointment - INTERVAL '1 hour' * p.work_time - INTERVAL '1 day' * ((p.work_time / 24)::INT))
                 AND o.is_actual = TRUE)
    THEN
        RAISE EXCEPTION 'Время % уже занято', _appointment;
    END IF;

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