CREATE TABLE IF NOT EXISTS customer.problemhistory
(
    vehicle_id  BIGINT       NOT NULL,
    problem     VARCHAR(500) NOT NULL,
    is_actual   BOOLEAN      NOT NULL,
    date_repair DATE         NOT NULL
);