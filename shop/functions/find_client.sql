CREATE OR REPLACE FUNCTION shop.find_client(_client_id integer) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT t.naz   AS Название,
                     t.price AS Цена,
                     SUM(p.kol) Количество
              FROM tovar t
                       INNER JOIN prod p ON p.t_id = t.id
                       INNER JOIN shop.client c on p.cl_id = c.client_id
              WHERE _client_id = c.client_id
              group by t.naz, t.price) res;
END
$$;