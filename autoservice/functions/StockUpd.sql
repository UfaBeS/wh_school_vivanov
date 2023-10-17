CREATE OR REPLACE FUNCTION autoservice.stockupd(_src JSONB, _stock_id BIGINT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _detail_id BIGINT;
    _quantity  BIGINT;
BEGIN
    SELECT s.detail_id,
           s.quantity
    INTO _detail_id, _quantity
    FROM jsonb_to_record(_src) AS s (detail_id BIGINT, quantity BIGINT);

    INSERT INTO autoservice.stock AS s (stock_id,
                                        detail_id,
                                        quantity)
    SELECT _stock_id,
           _detail_id,
           _quantity
    ON CONFLICT (stock_id, detail_id) DO UPDATE
        SET quantity = s.quantity + excluded.quantity;

    RETURN jsonb_build_object('data', NULL);
END
$$;