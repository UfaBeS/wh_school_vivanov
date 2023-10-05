CREATE TABLE order.orders
(
    order_id   BIGINT      NOT NULL
        CONSTRAINT pk_order_id PRIMARY KEY,
    order_date DATE        NOT NULL,
    service_id INT         NOT NULL,
    vehicle_id INT         NOT NULL,
    status     VARCHAR(20) NOT NULL
);