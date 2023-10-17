CREATE TABLE IF NOT EXISTS dictionary.types_car
(
    type_car_id SMALLSERIAL NOT NULL
        CONSTRAINT pk_types_car PRIMARY KEY,
    name_type   VARCHAR(20) NOT NULL
);