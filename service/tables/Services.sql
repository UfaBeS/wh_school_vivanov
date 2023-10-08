CREATE TABLE IF NOT EXISTS service.services
(
    service_id   BIGINT         NOT NULL
        CONSTRAINT pk_service_id PRIMARY KEY,
    service_name VARCHAR(500)   NOT NULL,
    price        DECIMAL(10, 2) NOT NULL, --для разных машин разная
    type_car     INT            NOT NULL,
        CONSTRAINT uq_service_type_car UNIQUE (service_id, type_car)
);