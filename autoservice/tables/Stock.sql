CREATE TABLE IF NOT EXISTS autoservice.stock
(
    stock_id  BIGINT NOT NULL,
        CONSTRAINT pk_stock_stock_id_detail_id PRIMARY KEY (stock_id,detail_id),
    detail_id BIGINT NOT NULL,
    quantity  BIGINT NOT NULL
); -- добавить хп