CREATE TABLE IF NOT EXISTS history.serviceschanges
(
    log_id       BIGSERIAL    NOT NULL
        CONSTRAINT pk_log_id PRIMARY KEY,
    service_id   BIGINT         NOT NULL,
    service_name VARCHAR(500)   NOT NULL,
    price        DECIMAL(10, 2) NOT NULL,
    type_car     INT            NOT NULL,
        CONSTRAINT uq_service_type_car UNIQUE (service_id, type_car)
);