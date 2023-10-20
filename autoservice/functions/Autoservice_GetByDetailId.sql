CREATE OR REPLACE FUNCTION autoservice.autoservice_getbydetailid(_detail_id BIGINT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT d.detail_id,
                     d.detail_name,
                     d.brand_id,
                     d.model,
                     s.stock_id,
                     s.quantity
              FROM autoservice.details d
                       INNER JOIN autoservice.stock s on d.detail_id = s.detail_id
              WHERE d.detail_id = _detail_id) res;
END
$$;