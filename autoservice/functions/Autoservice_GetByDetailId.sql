CREATE OR REPLACE FUNCTION autoservice.autoservice_getbydetailid(_detail_id BIGINT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT d.detail_id   AS Айди_детали,
                     d.detail_name AS Название,
                     d.brand_id    AS Айди_бренда,
                     d.model       AS Модель,
                     s.stock_id    AS Склад,
                     s.quantity    AS Остаток
              FROM autoservice.details d
                       INNER JOIN autoservice.stock s on d.detail_id = s.detail_id
              WHERE d.detail_id = _detail_id) res;
END
$$;