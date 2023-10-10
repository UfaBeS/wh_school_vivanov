CREATE TABLE IF NOT EXISTS storage.details
(
    detail_id   BIGINT       NOT NULL,
    detail_name VARCHAR(500) NOT NULL,
    brand_id    INT          NOT NULL,
    model       VARCHAR(50)  NOT NULL
);