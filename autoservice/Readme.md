# Схема `autoservice`

## Таблица `details`

Таблица `details` содержит информацию о запчастях (деталях).

### Структура таблицы

1. `detail_id` (тип: BIGINT, NOT NULL) - Уникальный идентификатор детали (первичный ключ).
2. `detail_name` (тип: VARCHAR(500), NOT NULL) - Название детали.
3. `brand_id` (тип: SMALLINT, NOT NULL) - Уникальный идентификатор производителя (связь с
   таблицей `dictionary.vehiclebrands`).
4. `model` (тип: VARCHAR(50), NOT NULL) - Модель детали.

## Функция `detailsupd`

Функция `detailsupd` предназначена для добавления или обновления записей в таблице `details`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о детали. Может включать следующие поля:
    - `detail_id` (тип: BIGINT) - Уникальный идентификатор детали. Если не указан, то будет создан новый.
    - `detail_name` (тип: VARCHAR(500), NOT NULL) - Название детали.
    - `brand_id` (тип: SMALLINT, NOT NULL) - Уникальный идентификатор производителя (связь с
      таблицей `dictionary.vehiclebrands`).
    - `model` (тип: VARCHAR(50), NOT NULL) - Модель детали.

### Примеры использования функции

1. Добавление новой детали:

```sql
SELECT autoservice.detailsupd('
{
    "detail_name": "Свеча зажигания",
    "brand_id": 1,
    "model": "Standard"
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

2. Обновление существующей детали (по detail_id):

```sql 
SELECT autoservice.detailsupd('
{
    "detail_id": 1,
    "detail_name": "Свеча зажигания NGK",
    "brand_id": 2,
    "model": "Super Performance"
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

## Таблица `orders`

### Структура таблицы

1. `order_id` (тип: BIGINT, NOT NULL) - Уникальный идентификатор заказа. Первичный ключ таблицы.
2. `order_date` (тип: TIMESTAMPTZ, NOT NULL) - Дата и время создания заказа.
3. `service_id` (тип: INT, NOT NULL) - Идентификатор услуги, связанной с заказом.
4. `vehicle_id` (тип: BIGINT, NOT NULL) - Идентификатор автомобиля, к которому относится заказ.
5. `status` (тип: CHAR(3), NOT NULL) - Статус заказа.
6. `appointment` (тип: TIMESTAMPTZ, NOT NULL) - Дата и время назначенного приема.
7. `problem` (тип: VARCHAR(500), NOT NULL) - Описание проблемы, указанной в заказе.
8. `is_actual` (тип: BOOLEAN, NOT NULL) - Флаг актуальности заказа.

## Функция `ordersupd`

Функция `ordersupd` предназначена для добавления или обновления записей в таблице `orders`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о заказе. Может включать следующие поля:
    - `order_id` (тип: BIGINT) - Уникальный идентификатор заказа. Если не указан, то будет создан новый.
    - `service_id` (тип: INT, NOT NULL) - Идентификатор услуги.
    - `vehicle_id` (тип: BIGINT, NOT NULL) - Идентификатор автомобиля.
    - `status` (тип: CHAR(3), NOT NULL) - Статус заказа.
    -
        * `status` ("new") заказ принят.
    *
        * `status` ("prg") заказ принят.
    *
        * `status` ("rdy") заказ принят.

    - `appointment` (тип: TIMESTAMPTZ, NOT NULL) - Дата и время записи.
    - `problem` (тип: VARCHAR(500), NOT NULL) - Описание проблемы.
    - `is_actual` (тип: BOOLEAN, NOT NULL) - Флаг актуальности заказа.

### Примеры использования функции

1. Добавление нового заказа:

```sql
SELECT autoservice.ordersupd('
{
    "vehicle_id": 123,
    "status": "new",
    "appointment": "2023-09-15 10:00:00",
    "problem": "Замена масла",
    "is_actual": true
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

2. Обновление существующего заказа (по order_id):

```sql
SELECT autoservice.ordersupd('
{
    "service_id": 1,
    "vehicle_id": 123,
    "status": "prg",
    "appointment": "2023-09-15 10:00:00",
    "problem": "Замена масла",
    "is_actual": true
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

Пример ошибки:

```jsonb
{
  "errors": [
    {
      "error": "autoservice.order_time_is_busy",
      "detail": "order_id = 13 appointment = 2023-09-15 10:00:00",
      "message": "Данное время уже занято!"
    }
  ]
}
```

## Таблица `prices`

### Структура таблицы

1. `service_id` (тип: INT, NOT NULL) - Уникальный идентификатор услуги. Первичный ключ таблицы.
2. `service_name` (тип: VARCHAR(500), NOT NULL) - Наименование услуги.
3. `price` (тип: NUMERIC(10, 2), NOT NULL) - Цена услуги.
4. `work_time` (тип: NUMERIC(4, 2), NOT NULL) - Время выполнения услуги (в часах).
5. `type_car_id` (тип: SMALLINT, NOT NULL) - Идентификатор типа автомобиля, к которому относится услуга.

## Функция `pricesupd`

Функция `pricesupd` предназначена для добавления или обновления записей в таблице `prices`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию об услуге. Может включать следующие поля:
    - `service_id` (тип: INT) - Уникальный идентификатор услуги. Если не указан, то будет создан новый.
    - `service_name` (тип: VARCHAR(500), NOT NULL) - Наименование услуги.
    - `price` (тип: NUMERIC(10, 2), NOT NULL) - Цена услуги.
    - `work_time` (тип: NUMERIC(4, 2), NOT NULL) - Время выполнения услуги (в часах).
    - `type_car_id` (тип: SMALLINT, NOT NULL) - Идентификатор типа автомобиля, к которому относится услуга.

### Примеры использования функции

1. Добавление новой услуги:

```sql
SELECT autoservice.pricesupd('
{
    "service_name": "Замена масла",
    "price": 50.00,
    "work_time": 1.5,
    "type_car_id": 1
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

2. Обновление существующей услуги (по `service_id` и `type_car_id`):

```sql
SELECT autoservice.pricesupd('
{
    "service_id": 1,
    "service_name": "Полная замена масла",
    "price": 75.00,
    "work_time": 2.0,
    "type_car_id": 1
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

## Таблица `employeetasks`

### Структура таблицы

1. `employee_task_id` (тип: BIGINT, NOT NULL) - Уникальный идентификатор задачи для сотрудника. Первичный ключ таблицы.
2. `vehicle_id` (тип: BIGINT, NOT NULL) - Идентификатор автомобиля, к которому относится заказ.
3. `repair_status` (тип: VARCHAR(20), NOT NULL) - Статус задачи по ремонту.
4. `responsible_employee_id` (тип: INT, NOT NULL) - Идентификатор сотрудника, ответственного за выполнение задачи.
5. `ch_employee_id` (тип: INT, NOT NULL) - Идентификатор сотрудника, изменившего статус задачи.
6. `ch_dt` (тип: TIMESTAMPTZ, NOT NULL) - Дата и время изменения статуса задачи.

## Функция `employeetasksupd`

Функция `employeetasksupd` предназначена для добавления или обновления записей в таблице `employeetasks`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о задаче сотрудника. Может включать следующие поля:
    - `employee_task_id` (тип: BIGINT) - Уникальный идентификатор задачи. Если не указан, то будет создан новый.
    - `vehicle_id` (тип: BIGINT, NOT NULL) - Идентификатор автомобиля.
    - `repair_status` (тип: VARCHAR(20), NOT NULL) - Статус задачи по ремонту.
    - `responsible_employee_id` (тип: INT, NOT NULL) - Идентификатор сотрудника, ответственного за выполнение задачи.
- `_ch_employee_id` (тип: INT) - Идентификатор сотрудника, изменившего статус задачи.

### Примеры использования функции

1. Добавление новой задачи для сотрудника:

```sql
SELECT autoservice.employeetasksupd('
{
    "vehicle_id": 1,
    "repair_status": "In Progress",
    "responsible_employee_id": 123
}', 456);
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

2. Обновление существующей задачи (по `employee_task_id`):

```sql
SELECT autoservice.employeetasksupd('
{
    "employee_task_id": 1,
    "vehicle_id": 1,
    "repair_status": "Completed",
    "responsible_employee_id": 456
}', 789);
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

## Таблица `stock`

### Структура таблицы

1. `stock_id` (тип: BIGINT, NOT NULL) - Уникальный идентификатор склада. Первичный ключ таблицы.
2. `detail_id` (тип: BIGINT, NOT NULL) - Уникальный идентификатор детали на складе.
3. `quantity` (тип: BIGINT, NOT NULL) - Количество деталей на складе.

## Функция `stockupd`

Функция `stockupd` предназначена для добавления или обновления записей в таблице `stock`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о складе и детали. Может включать следующие поля:
    - `detail_id` (тип: BIGINT) - Уникальный идентификатор детали на складе.
    - `quantity` (тип: BIGINT) - Количество деталей на складе.
- `_stock_id` (тип: BIGINT) - Уникальный идентификатор склада.

### Примеры использования функции

1. Добавление новой записи о детали на складе:

```sql
SELECT autoservice.stockupd('
{
    "detail_id": 123,
    "quantity": 50
}', 1);
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

2. Обновление существующей записи о детали на складе (по `stock_id` и `detail_id`):

```sql
SELECT autoservice.stockupd('
{
    "detail_id": 123,
    "quantity": 100
}', 2);
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

## Функция `autoservice_getbydetailid`

Функция `autoservice_getbydetailid` предназначена для получения информации о детали по её идентификатору.

### Параметры функции

- `_detail_id` (тип: BIGINT) - Уникальный идентификатор детали.

### Пример использования функции

```sql
SELECT autoservice.autoservice_getbydetailid(1);
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "detail_id": 1,
      "detail_name": "Название детали",
      "brand_id": 1,
      "model": "Модель",
      "stock_id": 5,
      "quantity": 10
    }
  ]
}
```

## Функция `autoservice_getbyorderid`

Функция `autoservice_getbyorderid` предназначена для получения информации о заказе по его идентификатору.

### Параметры функции

- `_order_id` (тип: BIGINT) - Уникальный идентификатор заказа.

### Пример использования функции

```sql
SELECT autoservice.autoservice_getbyorderid(54321);
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "order_id": 54321,
      "order_date": "2023-01-15T14:30:00Z",
      "service_id": 1,
      "service_name": "Замена масла",
      "vehicle_id": 987,
      "name": "Иван Иванов",
      "phone": "1234567890",
      "vin": "ABCD1234",
      "status": "Выполнен",
      "appointment": "2023-01-20T10:00:00Z",
      "problem": "Замена масла и фильтра"
    }
  ]
}
```

## Функция `autoservice_getbyrespemployeeid`

Функция `autoservice_getbyrespemployeeid` предназначена для получения информации о задачах, назначенных на ответственного сотрудника по его идентификатору.

### Параметры функции

- `_responsible_employee_id` (тип: BIGINT) - Уникальный идентификатор ответственного сотрудника.

### Пример использования функции

```sql
SELECT autoservice.autoservice_getbyrespemployeeid(12345);
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "employee_task_id": 1,
      "vehicle_id": 987,
      "repair_status": "В работе",
      "responsible_employee_id": 12345,
      "name": "Иван Иванов",
      "phone": "1234567890"
    }
  ]
}
```

## Функция `autoservice_getbyserviceid`

Функция `autoservice_getbyserviceid` предназначена для получения информации о сервисе по его идентификатору.

### Параметры функции

- `_service_id` (тип: INT) - Уникальный идентификатор сервиса.

### Пример использования функции

```sql
SELECT autoservice.autoservice_getbyserviceid(54321);
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "service_id": 54321,
      "service_name": "Замена масла",
      "price": 50.00,
      "work_time": 1.5,
      "type_car_id": 1,
      "detail_id": 12345,
      "detail_name": "Масляный фильтр"
    }
  ]
}
```