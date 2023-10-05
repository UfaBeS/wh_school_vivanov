CREATE TABLE IF NOT EXISTS vehicle.vehicles
(
    vehicle_id BIGINT             NOT NULL
        CONSTRAINT pk_vehicles PRIMARY KEY,
    make       VARCHAR(50)        NOT NULL,
    model      VARCHAR(50)        NOT NULL,
    year       INT,
    type_car   VARCHAR(16)        NOT NULL,
    car_vin    VARCHAR(17) UNIQUE NOT NULL,
    problem    VARCHAR(500)
);