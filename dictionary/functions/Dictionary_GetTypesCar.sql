CREATE OR REPLACE FUNCTION dictionary.dictionary_gettypescar() RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT t.type_car_id AS Айди_типа_автомобиля,
                     t.name_type   AS Название_типа_автомобиля
              FROM dictionary.typescar t) res;
END
$$;