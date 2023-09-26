CREATE OR REPLACE FUNCTION shop.bigavg_tovar() RETURNS jsonb
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
              group by c.client_id, c.name, c.phone
              having sum(kol) > (with find_sum AS
                                          (SELECT c.client_id AS id,
                                                  sum(kol)    AS suma
                                           FROM shop.client c
                                                    INNER JOIN Prod p ON p.cl_id = c.client_id
                                           GROUP BY c.client_id)
                                 SELECT avg(suma)
                                 FROM find_sum)) res;
END
$$;