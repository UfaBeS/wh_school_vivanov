CREATE OR REPLACE FUNCTION dictionary.servicedetailsupd(_src JSONB,_service_id INT) RETURNS JSONB --
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _type_car_id SMALLINT;
    _detail_id   BIGINT;
BEGIN
    SELECT s.type_car_id,
           s.detail_id
    INTO _type_car_id, _detail_id
    FROM jsonb_to_record(_src) AS s (type_car_id SMALLINT,
                                     detail_id BIGINT);

    INSERT INTO dictionary.servicedetails AS s (service_id,
                                                type_car_id,
                                                detail_id)
    SELECT _service_id,
           _type_car_id,
           _detail_id
    ON CONFLICT (service_id) DO UPDATE
        SET type_car_id = excluded.type_car_id,
            detail_id   = excluded.detail_id;

    RETURN jsonb_build_object('data', NULL);
END
$$;