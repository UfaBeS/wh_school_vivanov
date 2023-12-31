CREATE TABLE IF NOT EXISTS dictionary.specialization
(
    specialization_id   INT         NOT NULL
        CONSTRAINT pk_specialization PRIMARY KEY,
    specialization_name VARCHAR(64) NOT NULL,
    service_id          INT         NOT NULL,
    skill_lvl           VARCHAR(6)  NOT NULL,
    max_queue           SMALLINT    NOT NULL
);