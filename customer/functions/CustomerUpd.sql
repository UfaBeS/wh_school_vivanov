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
    SELECT coalesce(s.customer_id, nextval('customer.customerssq')) AS customer_id,
           s.name,
           s.phone,
           s.vehicle_id
    INTO _customer_id, _name, _phone, _vehicle_id
    FROM jsonb_to_record(_src) AS s (customer_id INT,
                                     name VARCHAR(30),
                                     phone VARCHAR(11),
                                     vehicle_id INT);

    IF exists(SELECT 1
              FROM customer.customers c
                       INNER JOIN customer.vehicles v ON c.vehicle_id = v.vehicle_id
              WHERE v.vehicle_id = _vehicle_id
                AND c.customer_id != _customer_id)
    THEN
        RETURN public.errmessage(_errcode := 'customer.customers_customer_vehicle_error',
                                 _msg := 'Машина принадлежит другому владельцу!',
                                 _detail := concat('customer = ', _customer_id, ' ', 'vehicle =', _vehicle_id));
    END IF;

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
        SET name       = excluded.name,
            phone      = excluded.phone,
            vehicle_id = excluded.vehicle_id;

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