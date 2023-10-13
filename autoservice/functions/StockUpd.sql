CREATE OR REPLACE FUNCTION autoservice.stockupd(_src JSONB, _stock_id BIGINT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _detail_id BIGINT;
    _quantity  BIGINT;
BEGIN
    SET TIME ZONE 'Europe/Moscow';

    SELECT s.detail_id,
           s.quantity
    INTO _detail_id, _quantity
    FROM jsonb_to_record(_src) AS s (detail_id BIGINT, quantity BIGINT);

    IF _quantity <= 0
    THEN
        RETURN public.errmessage(_errcode := 'autoservice.stock_invalid_quantity',
                                 _msg := 'Количество деталей должно быть больше 0.');
    END IF;

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