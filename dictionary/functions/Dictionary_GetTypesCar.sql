CREATE OR REPLACE FUNCTION dictionary.dictionary_gettypescar() RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT t.type_car_id,
                     t.name_type
              FROM dictionary.typescar t) res;
END
$$;