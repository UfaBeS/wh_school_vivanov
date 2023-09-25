CREATE OR REPLACE FUNCTION shop.day_find(_dt DATE) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT t.naz  AS Название,
                     p.kol  AS Цена,
                     c.name AS Имя
              FROM shop.client c
                       INNER JOIN prod p ON p.cl_id = c.client_id
                       INNER JOIN tovar t on t.id = p.t_id
              WHERE DATE(p.dt) = _dt) res;
END
$$;