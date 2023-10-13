CREATE TABLE IF NOT EXISTS customer.customers
(
    customer_id    BIGINT      NOT NULL,
    name           VARCHAR(50) NOT NULL,
    phone          VARCHAR(12),
    vehicle_id     INT         NOT NULL,
        CONSTRAINT pk_customers_customer_id_vehicle_id PRIMARY KEY (customer_id, vehicle_id),
    ch_employee_id INT         NOT NULL,
    ch_dt          timestamptz NOT NULL
);
-- И клиент и машина, проверка принадлежит ли машина кому-то еще,
--IF EXSIST
--get ищем клиента по машине
-- возвращать не null а vin машины
--поиск по машине, поиск клиента по номеру тф, создание нового автомобиля, создание нового клиента
--перед обновление данных клиента, проверить привязана ли машина к другому клиенту
--2 гет функции, поиск по вин, поиск id по машине

