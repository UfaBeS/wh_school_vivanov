CREATE TABLE IF NOT EXISTS storage.stock
(
    stock_id  BIGINT NOT NULL
        CONSTRAINT pk_service_id PRIMARY KEY,
    detail_id BIGINT NOT NULL,
    quantity  BIGINT NOT NULL
);