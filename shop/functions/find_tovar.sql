CREATE OR REPLACE FUNCTION shop.find_tovar(_tid integer) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT c.client_id AS Айди,
                     c.name      AS Имя,
                     c.phone        Номер
              FROM shop.client c
                       INNER JOIN prod p ON p.cl_id = c.client_id
                       INNER JOIN tovar t on t.id = p.t_id
              WHERE t.id = _tid
              group by c.client_id, c.name, c.phone) res;
END
$$;