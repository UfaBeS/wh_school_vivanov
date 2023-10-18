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
    SELECT coalesce(s.detail_id, nextval('autoservice.autoservicesq')) AS detail_id,
           s.detail_name,
           s.brand_id,
           s.model
    INTO _detail_id, _detail_name, _brand_id, _model
    FROM jsonb_to_record(_src) AS s (detail_id BIGINT,
                                     detail_name VARCHAR(500),
                                     brand_id SMALLINT,
                                     model VARCHAR(50));

    INSERT INTO autoservice.details AS c(detail_id,
                                         detail_name,
                                         brand_id,
                                         model)
    SELECT _detail_id,
           _detail_name,
           _brand_id,
           _model
    ON CONFLICT (detail_id) DO UPDATE
        SET detail_name = excluded.detail_name,
            brand_id    = excluded.brand_id,
            model       = excluded.model;

    RETURN jsonb_build_object('data', NULL);
END
$$;