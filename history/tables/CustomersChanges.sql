CREATE TABLE IF NOT EXISTS history.customerschanges
(
    log_id         BIGSERIAL   NOT NULL
        CONSTRAINT pk_customerschanges PRIMARY KEY,
    customer_id    BIGINT      NOT NULL,
    name           VARCHAR(50) NOT NULL,
    phone          VARCHAR(15),
    vehicle_id     INT         NOT NULL,
    ch_employee_id INT         NOT NULL,
    ch_dt          timestamptz NOT NULL
);