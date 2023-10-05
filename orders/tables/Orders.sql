CREATE TABLE IF NOT EXISTS order.orders
(
    order_id      BIGINT      NOT NULL
        CONSTRAINT pk_order_id PRIMARY KEY,
    order_date    TIMESTAMPTZ NOT NULL,
    service_id    INT         NOT NULL,
    vehicle_id    INT         NOT NULL,
    repair_status VARCHAR(20) NOT NULL,
    appointment   DATE        NOT NULL,
    detail_repair BOOLEAN     NOT NULL,
    detail_id     BIGINT
);
