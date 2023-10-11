CREATE TABLE IF NOT EXISTS dictionary.vehiclebrands
(
    brand_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_vehiclebrands PRIMARY KEY,
    name     VARCHAR(32) NOT NULL,
    country  VARCHAR(32) NOT NULL
);