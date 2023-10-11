CREATE TABLE IF NOT EXISTS history.employeeschanges
(
    log_id            BIGSERIAL   NOT NULL
        CONSTRAINT pk_employeeschanges PRIMARY KEY,
    employee_id       INT         NOT NULL,
    phone             VARCHAR(11) NOT NULL,
    name              VARCHAR(64) NOT NULL,
    birth_date        DATE        NOT NULL,
    specialization_id INT         NOT NULL,
    is_active         BOOLEAN     NOT NULL,
    ch_employee_id    INT         NOT NULL,
    ch_dt             timestamptz NOT NULL
);