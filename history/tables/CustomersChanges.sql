CREATE TABLE IF NOT EXISTS history.customerschanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_log_id PRIMARY KEY,
    customer_id BIGINT      NOT NULL,
    name        VARCHAR(50) NOT NULL,
    phone       VARCHAR(15),
    vehicle_id  INT         NOT NULL

);