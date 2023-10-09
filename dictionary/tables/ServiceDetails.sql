CREATE TABLE IF NOT EXISTS dictionary.servicedetails
(
    service_id BIGINT NOT NULL,
    type_car   INT    NOT NULL,
        CONSTRAINT uq_service_type_car UNIQUE (service_id, type_car),
    detail_id  BIGINT
);