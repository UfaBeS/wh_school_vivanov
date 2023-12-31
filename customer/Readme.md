# Схема `customer`

## Таблица `customers`

### Структура таблицы

1. `customer_id` (тип: BIGINT, NOT NULL) - Уникальный идентификатор клиента. Первичный ключ таблицы.
2. `name` (тип: VARCHAR(50), NOT NULL) - Имя клиента.
3. `phone` (тип: VARCHAR(11)) - Номер телефона клиента.
4. `vehicle_id` (тип: INT, NOT NULL) - Идентификатор автомобиля клиента.
5. `ch_employee_id` (тип: INT, NOT NULL) - Идентификатор сотрудника, внесшего изменения.
6. `ch_dt` (тип: TIMESTAMPTZ, NOT NULL) - Дата и время внесения изменений.

### Функция `customerupd`

Функция `customerupd` предназначена для добавления или обновления записей в таблице `customers`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о клиенте. Может включать следующие поля:
    - `customer_id` (тип: BIGINT) - Уникальный идентификатор клиента. Если не указан, то будет создан новый.
    - `name` (тип: VARCHAR(30)) - Имя клиента.
    - `phone` (тип: VARCHAR(11)) - Номер телефона клиента.
    - `vehicle_id` (тип: INT, NOT NULL) - Идентификатор автомобиля клиента.
    - `ch_employee_id` (тип: INT, NOT NULL) - Идентификатор сотрудника, внесшего изменения.

### Примеры использования функции

1. Добавление нового клиента:

```sql
SELECT customer.customerupd('
{
    "name": "Катя",
    "phone": "89182222223",
    "vehicle_id": 2
}', 2252);
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

2. Обновление существующего клиента (по customer_id и vehicle_id):

```sql 
SELECT customer.customerupd('
{
    "customer_id": 1,
    "name": "Петр Петров",
    "phone": "9876543210",
    "vehicle_id": 123
}', 2252);
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
      "error": "customer.customers_customer_vehicle_error",
      "detail": "customer = 1 vehicle = 2",
      "message": "Машина принадлежит другому владельцу!"
    }
  ]
}
```

### Функция `customer_getbyphone`

Функция `customer_getbyphone` предназначена для получения информации о клиенте по номеру телефона.

### Параметры функции

- `_phone` (тип: VARCHAR(11)) - Номер телефона клиента.

### Пример использования функции

Получение информации о клиенте по номеру телефона:

```sql
SELECT customer.customer_getbyphone('1234567890');
```

Пример ответа:

```jsonb
{
  "data": [
    {
      "customer_id": 1,
      "name": "Иван Иванов",
      "phone": "1234567890",
      "vehicle_id": 123,
      "vin":"ABC123XYZ45678901"
    }
  ]
}
```

### Функция `customer_getbyvin`

Функция `customer_getbyvin` предназначена для получения информации о клиенте и машине по VIN-номеру автомобиля.

### Параметры функции

- `_vin` (тип: VARCHAR(17)) - VIN-номер автомобиля.

### Пример использования функции

Получение информации о клиенте по VIN-номеру автомобиля:

```sql
SELECT customer.customer_getbyvin('ABC123XYZ45678901');
```

Пример ответа:

```jsonb
{
  "data": [
    {
      "customer_id": 1,
      "name": "Иван Иванов",
      "phone": "1234567890",
      "vehicle_id": 123,
      "model": "Toyota",
      "country": "Япония",
      "type_car_id": "Легковой"
    }
  ]
}
```
## Таблица `vehicles`

### Структура таблицы

1. `vehicle_id` (тип: BIGINT, NOT NULL) - Уникальный идентификатор автомобиля. Первичный ключ таблицы.
2. `brand_id` (тип: SMALLINT, NOT NULL) - Идентификатор марки автомобиля.
3. `model` (тип: VARCHAR(50), NOT NULL) - Модель автомобиля.
4. `year` (тип: INT) - Год выпуска автомобиля.
5. `type_car_id` (тип: SMALLINT, NOT NULL) - Идентификатор типа автомобиля.
6. `vin` (тип: VARCHAR(17), NOT NULL) - Уникальный идентификационный номер (VIN) автомобиля.

### Примечания

- Поле `vin` имеет уникальное ограничение (UNIQUE).

## Функция `vehicleupd`

Функция `vehicleupd` предназначена для добавления или обновления записей в таблице `vehicles`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о транспортном средстве. Может включать следующие поля:
    - `vehicle_id` (тип: BIGINT) - Уникальный идентификатор автомобиля. Если не указан, то будет создан новый.
    - `brand_id` (тип: SMALLINT, NOT NULL) - Идентификатор марки автомобиля.
    - `model` (тип: VARCHAR(50), NOT NULL) - Модель автомобиля.
    - `year` (тип: INT) - Год выпуска автомобиля.
    - `type_car_id` (тип: SMALLINT, NOT NULL) - Идентификатор типа автомобиля.
    - `vin` (тип: VARCHAR(17), NOT NULL) - Уникальный идентификационный номер (VIN) автомобиля.

### Пример использования функции

```sql
SELECT customer.vehicleupd('
{
    "brand_id": 1,
    "model": "Camry",
    "year": 2020,
    "type_car_id": 2,
    "vin": "ABC123XYZ45678901"
}', 123);
```
Пример ответа при правильном выполнении:
```jsonb
{"data" : "ABC123XYZ45678901"}
```
2. Обновление существующего клиента (по customer_id и vehicle_id):

```sql 
SELECT customer.vehicleupd('
{  
    "vehicle_id": 1,
    "brand_id": 2,
    "model": "Camry",
    "year": 2021,
    "type_car_id": 2,
    "vin": "ABC123XYZ45678901"
}', 123);
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : "ABC123XYZ45678901"}
```

## Функция `customer_getbyphone`

Функция `customer_getbyphone` предназначена для получения информации о клиенте по номеру телефона.

### Параметры функции

- `_phone` (тип: VARCHAR(11)) - Номер телефона клиента.

### Пример использования функции

```sql
SELECT customer.customer_getbyphone('1234567890');
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "vin": "ABC123XYZ45678901",
      "name": "Петр Петров",
      "phone": "1234567890",
      "vehicle_id": 1,
      "customer_id": 1
    }
  ]
}
```

## Функция `customer_getbyvin`

Функция `customer_getbyvin` предназначена для получения информации о клиенте, его автомобиле и марке автомобиля по VIN-коду автомобиля.

### Параметры функции

- `_vin` (тип: VARCHAR(17)) - VIN-код автомобиля.

### Пример использования функции

```sql
SELECT customer.customer_getbyvin('ABC123XYZ45678901');
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "vin": "ABC123XYZ45678901",
      "name": "lada",
      "phone": "9876543210",
      "country": "japan",
      "name_type": "sedan",
      "vehicle_id": 1,
      "customer_id": 1
    }
  ]
}
```