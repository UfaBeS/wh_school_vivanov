CREATE TABLE IF NOT EXISTS history.customerschanges
(
    log_id         BIGSERIAL   NOT NULL
        CONSTRAINT pk_customerschanges PRIMARY KEY,
    customer_id    BIGINT      NOT NULL,
    name           VARCHAR(50) NOT NULL,
    phone          VARCHAR(15),
    vehicle_id     INT         NOT NULL,
    ch_employee_id INT         NOT NULL,
    ch_dt          timestamptz NOT NULL
)
    PARTITION BY RANGE (ch_dt);

CREATE TABLE IF NOT EXISTS history.customerschanges_202301 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-01-01') TO ('2023-02-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202302 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-02-01') TO ('2023-03-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202303 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-03-01') TO ('2023-04-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202304 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-04-01') TO ('2023-05-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202305 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-05-01') TO ('2023-06-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202306 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-06-01') TO ('2023-07-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202307 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-07-01') TO ('2023-08-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202308 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-08-01') TO ('2023-09-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202309 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-09-01') TO ('2023-10-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202310 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-10-01') TO ('2023-11-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202311 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-11-01') TO ('2023-12-01');

CREATE TABLE IF NOT EXISTS history.customerschanges_202312 PARTITION OF history.customerschanges
    FOR VALUES FROM ('2023-12-01') TO ('2024-01-01');