CREATE TABLE IF NOT EXISTS dictionary.vehiclebrands
(
    brand_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_brand_id PRIMARY KEY,
    name     VARCHAR(32) NOT NULL,
    country  VARCHAR(32) NOT NULL
);