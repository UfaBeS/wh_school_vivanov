CREATE TABLE IF NOT EXISTS history.serviceschanges
(
    log_id       BIGSERIAL    NOT NULL
        CONSTRAINT pk_serviceschanges PRIMARY KEY,
    service_id   BIGINT         NOT NULL,
    service_name VARCHAR(500)   NOT NULL,
    price        DECIMAL(10, 2) NOT NULL,
    type_car     INT            NOT NULL
);