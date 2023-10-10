CREATE TABLE IF NOT EXISTS customer.customers
(
    customer_id BIGINT      NOT NULL,
    name        VARCHAR(50) NOT NULL,
    phone       VARCHAR(12),
    vehicle_id  INT         NOT NULL,
        CONSTRAINT pk_customers_vehicle PRIMARY KEY (customer_id, vehicle_id)
);