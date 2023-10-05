CREATE TABLE IF NOT EXISTS order.queue
(
    order_id      BIGINT      NOT NULL,
    repair_status VARCHAR(20) NOT NULL,
    appointment   DATE        NOT NULL,
    employee_id   BIGINT      NOT NULL,
    work_time     DATE        NOT NULL
);