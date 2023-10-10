CREATE TABLE IF NOT EXISTS order.visit
(
    visit_id       BIGINT      NOT NULL
        CONSTRAINT pk_visit_id PRIMARY KEY,
    repair_status  VARCHAR(20) NOT NULL,
    schedule       TIMESTAMP,
    employee_id    INT         NOT NULL,
    ch_employee_id TIMESTAMPTZ NOT NULL,
    ch_dt          TIMESTAMPTZ NOT NULL
);