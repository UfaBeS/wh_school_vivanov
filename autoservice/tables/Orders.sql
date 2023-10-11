CREATE TABLE IF NOT EXISTS autoservice.orders
(
    order_id    BIGINT       NOT NULL
        CONSTRAINT pk_order_id PRIMARY KEY,
    order_date  TIMESTAMPTZ  NOT NULL,
    service_id  INT          NOT NULL,
    vehicle_id  INT          NOT NULL,
    status      CHAR(3)      NOT NULL,
    appointment TIMESTAMP    NOT NULL,
    problem     VARCHAR(500) NOT NULL,
    is_actual   BOOLEAN      NOT NULL
);
