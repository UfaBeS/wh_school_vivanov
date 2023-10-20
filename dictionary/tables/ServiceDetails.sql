CREATE TABLE IF NOT EXISTS dictionary.servicedetails
(
    service_id  INT      NOT NULL
        CONSTRAINT pk_servicedetails PRIMARY KEY,
    type_car_id SMALLINT NOT NULL,
    detail_id   BIGINT   NOT NULL,
    CONSTRAINT uq_servicedetails_type_car_detail_id UNIQUE (type_car_id, detail_id)
);