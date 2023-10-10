CREATE TABLE IF NOT EXISTS humanresource.employees
(
    employee_id       INT         NOT NULL
        CONSTRAINT pk_employees PRIMARY KEY,
    phone             VARCHAR(11) NOT NULL,
    name              VARCHAR(64) NOT NULL,
    birth_date        DATE        NOT NULL,
    specialization_id INT         NOT NULL
);