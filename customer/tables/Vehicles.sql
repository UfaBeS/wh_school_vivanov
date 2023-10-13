CREATE TABLE IF NOT EXISTS customer.vehicles
(
    vehicle_id  BIGINT      NOT NULL
        CONSTRAINT pk_vehicles PRIMARY KEY,
    brand_id    SMALLINT    NOT NULL,
    model       VARCHAR(50) NOT NULL,
    year        INT,
    type_car_id VARCHAR(16) NOT NULL,
    vin         VARCHAR(17) NOT NULL
        CONSTRAINT uq_vehicles_vin UNIQUE
);