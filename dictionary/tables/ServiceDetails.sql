CREATE TABLE IF NOT EXISTS dictionary.servicedetails
(
    service_id SERIAL NOT NULL,
    type_car   INT    NOT NULL,
    detail_id  BIGINT NOT NULL,
        CONSTRAINT uq_servicedetails_type_car_detail_id UNIQUE (type_car, detail_id)
);