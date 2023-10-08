CREATE OR REPLACE FUNCTION customer.customerupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _customer_id INT;
    _name        VARCHAR(30);
    _phone       VARCHAR(11);
    _vehicle_id  INT;
    _is_deleted  BOOLEAN;
BEGIN
    SET TIME ZONE 'Europe/Moscow';

    SELECT coalesce(s.customer_id, nextval('customer.customersq')) AS customer_id,
           s.name,
           s.phone,
           s.vehicle_id,
           s.is_deleted
    INTO _customer_id, _name, _phone, _vehicle_id, _is_deleted
    FROM jsonb_to_record(_src) AS s (customer_id INT,
                                     name VARCHAR(30),
                                     phone VARCHAR(11),
                                     vehicle_id INT,
                                     is_deleted boolean);
    IF _is_deleted = TRUE
    THEN
        DELETE
        FROM customer.customers c
        WHERE c.customer_id = _customer_id
          AND c.vehicle_id = _vehicle_id
          AND _is_deleted = TRUE;

        RETURN jsonb_build_object('data', NULL);
    END IF;

    IF exists(SELECT 1
              FROM customer.customers c
              WHERE c.customer_id = _customer_id
                AND c.vehicle_id = _vehicle_id)
    THEN
        RETURN public.errmessage(_errcode := 'customer.customers_customer_alredy_registred',
                                 _msg := 'Покупатель уже зарегестрирован!',
                                 _detail := concat('customer = ', _customer_id, ' ', 'vehicle =', _vehicle_id));
    END IF;

    INSERT INTO customer.customers AS c(customer_id,
                                        name,
                                        phone,
                                        vehicle_id)
    SELECT _customer_id,
           _name,
           _phone,
           _vehicle_id
    ON CONFLICT (customer_id) DO UPDATE
        SET name       = excluded.name,
            phone      = excluded.phone,
            vehicle_id = excluded.vehicle_id;


    INSERT INTO history.customerschanges (customer_id,
                                          name,
                                          phone,
                                          vehicle_id)
    SELECT _customer_id,
           _name,
           _phone,
           _vehicle_id;


    RETURN jsonb_build_object('data', NULL);
END
$$;