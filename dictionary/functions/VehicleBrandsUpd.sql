CREATE OR REPLACE FUNCTION dictionary.vehiclebrandupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _brand_id INT;
    _name     VARCHAR(32);
    _country  VARCHAR(32);
BEGIN
    SELECT coalesce(s.brand_id, nextval('dictionary.specializationsq')) AS brand_id,
           s.name,
           s.country
    INTO _brand_id, _name, _country
    FROM jsonb_to_record(_src) AS s(brand_id INT,
                                    name VARCHAR(32),
                                    country VARCHAR(32));

    INSERT INTO dictionary.vehiclebrands AS b (brand_id,
                                               name,
                                               country)
    SELECT _brand_id,
           _name,
           _country
    ON CONFLICT (brand_id) DO UPDATE
        SET name    = excluded.name,
            country = excluded.country;

    RETURN jsonb_build_object('data', NULL);
END
$$;