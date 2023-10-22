CREATE TABLE IF NOT EXISTS history.customerschanges
(
    log_id         BIGSERIAL   NOT NULL,
    customer_id    BIGINT      NOT NULL,
    name           VARCHAR(50) NOT NULL,
    phone          VARCHAR(11),
    vehicle_id     INT         NOT NULL,
    ch_employee_id INT         NOT NULL,
    ch_dt          timestamptz NOT NULL
)
    PARTITION BY RANGE (ch_dt);