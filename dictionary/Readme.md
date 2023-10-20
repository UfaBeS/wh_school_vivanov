# Схема `dictionary`
## Таблица `vehiclebrands`

### Структура таблицы

1. `brand_id` (тип: SMALLSERIAL, NOT NULL) - Уникальный идентификатор марки автомобиля. Первичный ключ таблицы.
2. `name` (тип: VARCHAR(32), NOT NULL) - Название марки автомобиля.
3. `country` (тип: VARCHAR(32), NOT NULL) - Страна производителя марки автомобиля.

## Функция `vehiclebrandupd`

Функция `vehiclebrandupd` предназначена для добавления или обновления записей в таблице `vehiclebrands`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о марке автомобиля. Может включать следующие поля:
    - `brand_id` (тип: SMALLSERIAL) - Уникальный идентификатор марки автомобиля. Если не указан, то будет создан новый.
    - `name` (тип: VARCHAR(32), NOT NULL) - Название марки автомобиля.
    - `country` (тип: VARCHAR(32), NOT NULL) - Страна производителя марки автомобиля.

### Пример использования функции
1. Добавление новой марки автомобиля
```sql
SELECT dictionary.vehiclebrandupd('
{
    "name": "Toyota",
    "country": "Japan"
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
2. Обновление существующей марки (по brand_id):

```sql 
SELECT dictionary.vehiclebrandupd('
{   
    "brand_id": 1,
    "name": "Honda",
    "country": "Japan"
}');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

## Таблица `typescar`

### Структура таблицы

1. `type_car_id` (тип: SMALLSERIAL, NOT NULL) - Уникальный идентификатор типа автомобиля. Первичный ключ таблицы.
2. `name_type` (тип: VARCHAR(20), NOT NULL) - Название типа автомобиля.

## Функция `typecarupd`

Функция `typecarupd` предназначена для добавления или обновления записей в таблице `typescar`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о типе автомобиля. Может включать следующие поля:
    - `type_car_id` (тип: SMALLSERIAL) - Уникальный идентификатор типа автомобиля. Если не указан, то будет создан новый.
    - `name_type` (тип: VARCHAR(20), NOT NULL) - Название типа автомобиля.

### Пример использования функции
1. Добавление нового типа автомобиля
```sql
SELECT dictionary.typecarupd('
{
    "name_type": "Седан"
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
2. Обновление существующего типа автомобиля (по type_car_id):

```sql 
SELECT dictionary.typecarupd('
{
    "type_car_id": 1,
    "name_type": "Хэтчбэк"
}');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

## Таблица `specialization`

### Структура таблицы

1. `specialization_id` (тип: INT, NOT NULL) - Уникальный идентификатор специализации. Первичный ключ таблицы.
2. `specialization_name` (тип: VARCHAR(64), NOT NULL) - Название специализации.
3. `service_id` (тип: INT, NOT NULL) - Идентификатор услуги, связанной с этой специализацией.
4. `skill_lvl` (тип: VARCHAR(6), NOT NULL) - Уровень навыков для этой специализации.
5. `max_queue` (тип: SMALLINT, NOT NULL) - Максимальная очередь для этой специализации.

## Функция `specializationupd`

Функция `specializationupd` предназначена для добавления или обновления записей в таблице `specialization`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о специализации. Может включать следующие поля:
    - `specialization_id` (тип: INT) - Уникальный идентификатор специализации. Если не указан, то будет создан новый.
    - `specialization_name` (тип: VARCHAR(64), NOT NULL) - Название специализации.
    - `service_id` (тип: INT, NOT NULL) - Идентификатор услуги.
    - `skill_lvl` (тип: VARCHAR(6), NOT NULL) - Уровень навыков.
    - `max_queue` (тип: SMALLINT, NOT NULL) - Максимальная очередь.

### Пример использования функции

1. Добавление новой специализации
```sql
SELECT dictionary.specializationupd('
{
    "specialization_name": "Мастер по кузовному ремонту",
    "service_id": 1,
    "skill_lvl": "Высокий",
    "max_queue": 10
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
2. Обновление существующей специализации (по specialization_id):

```sql
SELECT dictionary.specializationupd('
{
    "specialization_id": 1,
    "specialization_name": "Мастер по кузовному ремонту",
    "service_id": 1,
    "skill_lvl": "Высокий",
    "max_queue": 5
}');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

## Таблица `servicedetails`

### Структура таблицы

1. `service_id` (тип: INT, NOT NULL) - Уникальный идентификатор услуги. Первичный ключ таблицы.
2. `type_car_id` (тип: SMALLINT, NOT NULL) - Идентификатор типа автомобиля, связанного с данной услугой.
3. `detail_id` (тип: BIGINT, NOT NULL) - Идентификатор детали, связанной с услугой.
4. Ограничение уникальности: `uq_servicedetails_type_car_detail_id` (type_car_id, detail_id).

## Функция `servicedetailsupd`

Функция `servicedetailsupd` предназначена для добавления или обновления записей в таблице `servicedetails`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию об услуге. Может включать следующие поля:
    - `service_id` (тип: INT) - Уникальный идентификатор услуги. Если не указан, то будет создан новый.
    - `type_car_id` (тип: SMALLINT, NOT NULL) - Идентификатор типа автомобиля.
    - `detail_id` (тип: BIGINT, NOT NULL) - Идентификатор детали.

### Пример использования функции

1. Добавление информации (для какой услуги какие детали нужны)
```sql
SELECT dictionary.servicedetailsupd('
{   
    "service_id":1,
    "type_car_id": 1,
    "detail_id": 123
}');
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```
2. Обновление существующей информации (по service_id):

```sql
SELECT dictionary.servicedetailsupd('
{   
    "service_id":1,
    "type_car_id": 1,
    "detail_id": 12
}');
```
Пример ответа при правильном выполнении:

```jsonb
{"data" : null}
```

## Функция `dictionary_getbyserviceid`

Функция `dictionary_getbyserviceid` предназначена для получения информации о сервисе по его уникальному идентификатору (`service_id`).

### Параметры функции

- `_service_id` (тип: INT) - Уникальный идентификатор услуги.

### Пример использования функции

```sql
SELECT dictionary.dictionary_getbyserviceid(1);
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "service_id": 1,
      "type_car_id": 2,
      "detail_id": 123,
      "detail_name": "Фильтр масляный"
    }
  ]
}
```

## Функция `dictionary_getbyspecializationid`

Функция `dictionary_getbyspecializationid` предназначена для получения информации о специализации по ее уникальному идентификатору (`specialization_id`).

### Параметры функции

- `_specialization_id` (тип: INT) - Уникальный идентификатор специализации.

### Пример использования функции

```sql
SELECT dictionary.dictionary_getbyspecializationid(1);
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "specialization_id": 1,
      "specialization_name": "Механик",
      "service_id": 5,
      "skill_lvl": "Высокий",
      "max_queue": 10
    }
  ]
}
```

## Функция `dictionary_gettypescar`

Функция `dictionary_gettypescar` предназначена для получения информации о типах автомобилей (моделях).

### Параметры функции

Отсутствуют.

### Пример использования функции

```sql
SELECT dictionary.dictionary_gettypescar();
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "type_car_id": 1,
      "name_type": "Седан"
    },
    {
      "type_car_id": 2,
      "name_type": "Внедорожник"
    },
    {
      "type_car_id": 3,
      "name_type": "Хэтчбек"
    }
  ]
}
```

## Функция `dictionary_getvehiclebrands`

Функция `dictionary_getvehiclebrands` предназначена для получения информации о брендах автомобилей.

### Параметры функции

Отсутствуют.

### Пример использования функции

```sql
SELECT dictionary.dictionary_getvehiclebrands();
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "brand_id": 1,
      "name": "Toyota",
      "country": "Япония"
    },
    {
      "brand_id": 2,
      "name": "Ford",
      "country": "США"
    },
    {
      "brand_id": 3,
      "name": "Volkswagen",
      "country": "Германия"
    }
  ]
}
```