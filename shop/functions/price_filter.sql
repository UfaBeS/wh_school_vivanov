CREATE OR REPLACE FUNCTION shop.price_filter() RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT t.naz   AS Название,
                     t.price AS Цена
              FROM tovar t
              WHERE t.price BETWEEN 10 AND 30) res;
END
$$;