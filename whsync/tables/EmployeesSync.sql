CREATE TABLE IF NOT EXISTS whsync.employeessync
(
    log_id            BIGSERIAL                NOT NULL
        CONSTRAINT pk_employeessync PRIMARY KEY,
    employee_id       BIGINT                   NOT NULL,
    phone             VARCHAR(11)              NOT NULL,
    name              VARCHAR(64)              NOT NULL,
    birth_date        DATE                     NOT NULL,
    specialization_id INT                      NOT NULL,
    is_active         BOOLEAN                  NOT NULL,
    ch_employee_id    INT                      NOT NULL,
    ch_dt             TIMESTAMPTZ              NOT NULL,
    sync_dt           TIMESTAMP WITH TIME ZONE NULL
);