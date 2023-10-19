CREATE TABLE IF NOT EXISTS humanresource.employees
(
    employee_id       INT         NOT NULL
        CONSTRAINT pk_employees PRIMARY KEY,
    phone             VARCHAR(11) NOT NULL, -- по brand_id и по модели найти делать, поиск по статусам и на кого начислена задача
    name              VARCHAR(64) NOT NULL,
    birth_date        DATE        NOT NULL,
    specialization_id INT         NOT NULL,
    is_active         BOOLEAN     NOT NULL,
    ch_employee_id    INT         NOT NULL,
    ch_dt             TIMESTAMPTZ NOT NULL
);