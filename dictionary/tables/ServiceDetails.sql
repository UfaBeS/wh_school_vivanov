CREATE TABLE IF NOT EXISTS dictionary.servicedetails
(
    service_id SERIAL NOT NULL,
    type_car   INT    NOT NULL,
    detail_id  BIGINT NOT NULL
    CONSTRAINT uq_type_detail UNIQUE
);