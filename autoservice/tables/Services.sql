CREATE TABLE IF NOT EXISTS autoservice.services
(
    service_id   BIGINT         NOT NULL,
    service_name VARCHAR(500)   NOT NULL,
    price        DECIMAL(10, 2) NOT NULL,
    type_car     INT            NOT NULL,
        CONSTRAINT pk_service_type_car PRIMARY KEY (service_id, type_car)
);
