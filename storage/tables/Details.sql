CREATE TABLE IF NOT EXISTS storage.detailes
(
    detail_id   BIGINT         NOT NULL,
    detail_name VARCHAR(500)   NOT NULL,
    make        VARCHAR(50)    NOT NULL,
    model       VARCHAR(50)    NOT NULL,
    price       NUMERIC(10, 2) NOT NULL
);