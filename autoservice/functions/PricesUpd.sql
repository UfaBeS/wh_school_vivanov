CREATE OR REPLACE FUNCTION autoservice.pricesupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _service_id   INT;
    _service_name VARCHAR(500);
    _price        NUMERIC(10, 2);
    _work_time    NUMERIC(4, 2);
    _type_car     INT;
BEGIN
    SELECT coalesce(s.service_id, nextval('autoservice.autoservicesq')) AS service_id,
           s.service_name,
           s.price,
           s.work_time,
           s.type_car
    INTO _service_id, _service_name, _price, _work_time, _type_car
    FROM jsonb_to_record(_src) AS s (service_id INT,
                                     service_name VARCHAR(500),
                                     price NUMERIC(10, 2),
                                     work_time NUMERIC(4, 2),
                                     type_car INT);

    INSERT INTO autoservice.prices (service_id,
                                    service_name,
                                    price,
                                    work_time,
                                    type_car)
    SELECT _service_id,
           _service_name,
           _price,
           _work_time,
           _type_car
    ON CONFLICT (service_id, type_car) DO UPDATE
        SET service_name = excluded.service_name,
            price        = excluded.price,
            work_time    = excluded.work_time;

    INSERT INTO history.priceschanges (service_id,
                                       service_name,
                                       price,
                                       work_time,
                                       type_car)
    SELECT _service_id,
           _service_name,
           _price,
           _work_time,
           _type_car;


    RETURN jsonb_build_object('data', NULL);
END
$$;