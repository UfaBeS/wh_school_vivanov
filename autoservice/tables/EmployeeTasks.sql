CREATE TABLE IF NOT EXISTS autoservice.employeetasks
(
    employee_task_id        BIGINT      NOT NULL
        CONSTRAINT pk_employeetasks PRIMARY KEY,
    vehicle_id              BIGINT      NOT NULL,
    repair_status           VARCHAR(20) NOT NULL,
    responsible_employee_id INT         NOT NULL,
    ch_employee_id          INT         NOT NULL,
    ch_dt                   TIMESTAMPTZ NOT NULL
);