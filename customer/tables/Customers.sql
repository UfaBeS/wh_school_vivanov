CREATE TABLE IF NOT EXISTS customer.customers
(
    customer_id BIGINT      NOT NULL
        CONSTRAINT pk_customer_id PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    phone       VARCHAR(15),
    vehicle_id  INT         NOT NULL,
    CONSTRAINT uq_customer_vehicle UNIQUE (customer_id, vehicle_id)
);