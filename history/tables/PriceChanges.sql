CREATE TABLE IF NOT EXISTS history.pricechanges
(
    log_id     BIGSERIAL      NOT NULL
        CONSTRAINT pk_log_id PRIMARY KEY,
    service_id BIGINT         NOT NULL,
    price      DECIMAL(10, 2) NOT NULL, --для разных машин разная
    type_car   INT            NOT NULL
);