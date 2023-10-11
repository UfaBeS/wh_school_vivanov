CREATE TABLE IF NOT EXISTS autoservice.prices
(
    service_id   INT            NOT NULL,
    service_name VARCHAR(500)   NOT NULL,
    price        NUMERIC(10, 2) NOT NULL,
    work_time    NUMERIC(4, 2)  NOT NULL,
    type_car     INT            NOT NULL,
        CONSTRAINT pk_autoservice_service_id_type_car PRIMARY KEY (service_id, type_car)
);
