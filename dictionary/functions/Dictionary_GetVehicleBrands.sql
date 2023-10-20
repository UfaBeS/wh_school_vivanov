CREATE OR REPLACE FUNCTION dictionary.dictionary_getvehiclebrands() RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT v.brand_id,
                     v.name,
                     v.country
              FROM dictionary.vehiclebrands v) res;
END
$$;