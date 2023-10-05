CREATE TABLE customer.customers
(
    customer_id BIGINT      NOT NULL
        CONSTRAINT pk_customer_id PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    phone       VARCHAR(15),
    car_vin     INT         NOT NULL
);