CREATE TABLE IF NOT EXISTS dictionary.specialization
(
    employee_id BIGINT      NOT NULL
        CONSTRAINT pk_employees PRIMARY KEY,
    service_id  BIGINT      NOT NULL,
    skill_lvl   VARCHAR(64) NOT NULL
);