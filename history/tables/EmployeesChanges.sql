CREATE TABLE IF NOT EXISTS history.employeeschanges
(
    log_id      BIGSERIAL   NOT NULL
        CONSTRAINT pk_log_id PRIMARY KEY,
    employee_id BIGINT      NOT NULL,
    phone       VARCHAR(11) NOT NULL,
    name        VARCHAR(64) NOT NULL,
    birth_date  DATE        NOT NULL,
    ch_dt       TIMESTAMPTZ NOT NULL
);