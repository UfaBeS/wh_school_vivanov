CREATE OR REPLACE FUNCTION customer.customerupd(_src JSONB, _ch_employee_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _customer_id INT;
    _name        VARCHAR(30);
    _phone       VARCHAR(11);
    _vehicle_id  INT;
    _ch_dt       TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';


BEGIN
    SET TIME ZONE 'Europe/Moscow';

    SELECT coalesce(s.customer_id, nextval('customer.customersq')) AS customer_id,
           s.name,
           s.phone,
           s.vehicle_id
    INTO _customer_id, _name, _phone, _vehicle_id
    FROM jsonb_to_record(_src) AS s (customer_id INT,
                                     name VARCHAR(30),
                                     phone VARCHAR(11),
                                     vehicle_id INT);

    CASE
        WHEN exists(SELECT 1
                    FROM customer.customers c
                             INNER JOIN customer.vehicles v on c.vehicle_id = v.vehicle_id
                    WHERE c.name = _name
                      AND c.phone = _phone
                      AND c.vehicle_id = _vehicle_id)
            THEN RETURN public.errmessage(_errcode := 'customer.customers_customer_alredy_registred',
                                          _msg := 'Данный клиент уже зарегестрирован!',
                                          _detail := concat('customer = ', _customer_id, ' ', 'vehicle =', _vehicle_id));

        WHEN exists(SELECT 1
                    FROM customer.customers c
                             INNER JOIN customer.vehicles v on c.vehicle_id = v.vehicle_id
                    WHERE v.vehicle_id = _vehicle_id
                      AND c.customer_id != _customer_id)
            THEN RETURN public.errmessage(_errcode := 'customer.customers_vehicle_not_your',
                                          _msg := 'Машина принадлежит другому владельцу!',
                                          _detail := concat('customer = ', _customer_id, ' ', 'vehicle =', _vehicle_id));

        WHEN exists(SELECT 1
                    FROM customer.customers c
                             INNER JOIN customer.vehicles v on c.vehicle_id = v.vehicle_id
                    WHERE v.vehicle_id != _vehicle_id)
            THEN RETURN public.errmessage(_errcode := 'customer.customers_vehicle_not_exists',
                                          _msg := 'Машина не зарегистрирована!',
                                          _detail := concat('customer = ', _customer_id, ' ', 'vehicle =', _vehicle_id));
        ELSE
        END CASE;


    INSERT INTO customer.customers AS c (customer_id,
                                         name,
                                         phone,
                                         vehicle_id,
                                         ch_employee_id,
                                         ch_dt)
    SELECT _customer_id,
           _name,
           _phone,
           _vehicle_id,
           _ch_employee_id,
           _ch_dt

    ON CONFLICT (customer_id,vehicle_id) DO UPDATE
        SET name  = excluded.name,
            phone = excluded.phone;


    INSERT INTO history.customerschanges (customer_id,
                                          name,
                                          phone,
                                          vehicle_id,
                                          ch_employee_id,
                                          ch_dt)
    SELECT _customer_id,
           _name,
           _phone,
           _vehicle_id,
           _ch_employee_id,
           _ch_dt;


    RETURN jsonb_build_object('data', NULL);
END
$$;