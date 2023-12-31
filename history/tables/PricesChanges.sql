CREATE TABLE IF NOT EXISTS history.priceschanges
(
    log_id       BIGSERIAL      NOT NULL
        CONSTRAINT pk_priceschanges PRIMARY KEY,
    service_id   BIGINT         NOT NULL,
    service_name VARCHAR(500)   NOT NULL,
    price        DECIMAL(10, 2) NOT NULL,
    work_time    NUMERIC(4, 2)  NOT NULL,
    type_car_id  SMALLINT       NOT NULL
);