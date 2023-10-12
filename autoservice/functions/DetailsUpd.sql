CREATE OR REPLACE FUNCTION autoservice.detailsupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _detail_id   BIGINT;
    _detail_name VARCHAR(500);
    _brand_id    SMALLINT;
    _model       VARCHAR(50);
BEGIN
    SET TIME ZONE 'Europe/Moscow';

    SELECT coalesce(s.detail_id, nextval('autoservice.autoservicesq')) AS detail_id,
           s.detail_name,
           s.brand_id,
           s.model
    INTO _detail_id, _detail_name, _brand_id, _model
    FROM jsonb_to_record(_src) AS s (detail_id BIGINT,
                                     detail_name VARCHAR(500),
                                     brand_id SMALLINT,
                                     model VARCHAR(50));

    IF exists(SELECT 1
              FROM autoservice.details c
              WHERE c.detail_name = _detail_name
                AND c.brand_id = _brand_id
                AND c.model = _model)
    THEN
        RETURN public.errmessage(_errcode := 'autoservice.detail_detail_alredy_registred',
                                 _msg := 'Такая деталь уже зарегестрирована!',
                                 _detail := concat('detail_id = ', _detail_id, ' ', 'detail_name = ', _detail_name));

    END IF;
    INSERT INTO autoservice.details AS c(detail_id,
                                         detail_name,
                                         brand_id,
                                         model)
    SELECT _detail_id,
           _detail_name,
           _brand_id,
           _model
    ON CONFLICT (detail_id) DO UPDATE
        SET detail_name       = excluded.detail_name,
            brand_id      = excluded.brand_id,
            model = excluded.model;


/*    INSERT INTO history.customerschanges (customer_id,
                                          name,
                                          phone,
                                          vehicle_id)
    SELECT _customer_id,
           _name,
           _phone,
           _vehicle_id;*/


    RETURN jsonb_build_object('data', NULL);
END
$$;