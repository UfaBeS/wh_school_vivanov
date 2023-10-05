CREATE TABLE IF NOT EXISTS history.orders
(
    log_id     BIGSERIAL   NOT NULL
        CONSTRAINT pk_log_id PRIMARY KEY,
    order_id   BIGINT      NOT NULL,
    order_date DATE        NOT NULL,
    service_id INT         NOT NULL,
    vehicle_id INT         NOT NULL,
    status     VARCHAR(20) NOT NULL
);