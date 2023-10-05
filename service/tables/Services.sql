CREATE TABLE service.services
(
    service_id   BIGINT         NOT NULL
        CONSTRAINT pk_service_id PRIMARY KEY,
    service_name VARCHAR(500)   NOT NULL,
    price        DECIMAL(10, 2) NOT NULL
);