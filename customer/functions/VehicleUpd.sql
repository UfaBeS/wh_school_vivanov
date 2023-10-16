CREATE OR REPLACE FUNCTION customer.vehicleupd(_src JSONB, _customer_id BIGINT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE

    _vehicle_id BIGINT;
    _brand_id   SMALLINT;
    _model      VARCHAR(50);
    _year       INT;
    _type_car   VARCHAR(16);
    _vin        VARCHAR(17);

BEGIN
    SET TIME ZONE 'Europe/Moscow';

    SELECT coalesce(s.vehicle_id, nextval('customer.vehiclessq')) AS vehicle_id,
           s.brand_id,
           s.model,
           s.year,
           s.type_car,
           s.vin
    INTO _vehicle_id, _brand_id, _model, _year, _type_car, _vin
    FROM jsonb_to_record(_src) AS s (vehicle_id INT,
                                     brand_id SMALLINT,
                                     model VARCHAR(50),
                                     year INT,
                                     type_car VARCHAR(16),
                                     vin VARCHAR(17));

    IF exists(SELECT 1
              FROM customer.customers c
              WHERE c.vehicle_id = _vehicle_id
                AND c.customer_id != _customer_id)
    THEN
        RETURN public.errmessage(_errcode := 'customer.vehicle_vehicle_alredy_registred',
                                 _msg := 'Данный автомобиль пренадлежит другому клиенту!',
                                 _detail := concat('vehicle_id = ', _customer_id, ' ', 'vehicle =', _vehicle_id));
    END IF;

    INSERT INTO customer.vehicles AS v(vehicle_id,
                                       brand_id,
                                       model,
                                       year,
                                       type_car,
                                       vin)
    SELECT _vehicle_id,
           _brand_id,
           _model,
           _year,
           _type_car,
           _vin
    ON CONFLICT (vehicle_id) DO UPDATE
        SET brand_id = excluded.brand_id,
            model    = excluded.model,
            year     = excluded.year,
            type_car = excluded.type_car,
            vin      = excluded.vin;

    INSERT INTO history.vehiclechanges (vehicle_id,
                                        brand_id,
                                        model,
                                        year,
                                        type_car,
                                        vin)
    SELECT _vehicle_id,
           _brand_id,
           _model,
           _year,
           _type_car,
           _vin;

    RETURN jsonb_build_object('data', _vin);
END
$$;