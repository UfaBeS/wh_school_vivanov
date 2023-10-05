CREATE TABLE IF NOT EXISTS history.customers
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_log_id PRIMARY KEY,
    customer_id BIGINT      NOT NULL,
    name        VARCHAR(50) NOT NULL,
    phone       VARCHAR(15),
    car_vin     INT         NOT NULL,
    order_date  DATE        NOT NULL

)