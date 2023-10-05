CREATE TABLE vehicle.vehicles
(
    vehicle_id  BIGINT             NOT NULL
        CONSTRAINT pk_vehicles PRIMARY KEY,
    make        VARCHAR(50)        NOT NULL,
    model       VARCHAR(50)        NOT NULL,
    year        INT,
    car_vin     VARCHAR(17) UNIQUE NOT NULL,
    customer_id BIGINT             NOT NULL
);