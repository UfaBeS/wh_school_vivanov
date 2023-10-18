CREATE OR REPLACE FUNCTION dictionary.typecarupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _type_car_id INT;
    _name_type   VARCHAR(20);
BEGIN
    SELECT coalesce(s.type_car_id, nextval('dictionary.specializationsq')) AS type_car_id,
           s.name_type
    INTO _type_car_id, _name_type
    FROM jsonb_to_record(_src) AS s (type_car_id INT,
                                     name_type VARCHAR(20));

    INSERT INTO dictionary.typescar AS t (type_car_id,
                                           name_type)
    SELECT _type_car_id,
           _name_type
    ON CONFLICT (type_car_id) DO UPDATE
        SET name_type = excluded.name_type;

    RETURN jsonb_build_object('data', NULL);
END
$$;