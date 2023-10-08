CREATE TABLE IF NOT EXISTS history.serviceschanges
(
    log_id       BIGSERIAL    NOT NULL
        CONSTRAINT pk_log_id PRIMARY KEY,
    service_id   BIGINT       NOT NULL
        CONSTRAINT pk_service_id PRIMARY KEY,
    service_name VARCHAR(500) NOT NULL
);