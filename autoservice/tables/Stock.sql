CREATE TABLE IF NOT EXISTS autoservice.stock
(
    stock_id  BIGINT NOT NULL
        CONSTRAINT pk_stock PRIMARY KEY,
    detail_id BIGINT NOT NULL,
    quantity  BIGINT NOT NULL
);