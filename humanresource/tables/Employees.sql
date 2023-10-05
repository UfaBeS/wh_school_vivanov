CREATE TABLE IF NOT EXISTS humanresource.employees
(
    employee_id  BIGINT      NOT NULL
        CONSTRAINT pk_employees PRIMARY KEY,
    phone_number VARCHAR(11) NOT NULL,
    name         VARCHAR(64) NOT NULL,
    birth_date   DATE        NOT NULL,
    position     VARCHAR(64) NOT NULL,
    ch_dt        TIMESTAMPTZ NOT NULL
);