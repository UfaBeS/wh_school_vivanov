
# Схема `whsync`

## Таблица `employeessync`

### Структура таблицы

1. `log_id` (тип: BIGSERIAL, NOT NULL) - Уникальный идентификатор записи синхронизации. Первичный ключ таблицы.
2. `employee_id` (тип: BIGINT, NOT NULL) - Уникальный идентификатор сотрудника.
3. `phone` (тип: VARCHAR(11), NOT NULL) - Номер телефона сотрудника.
4. `name` (тип: VARCHAR(64), NOT NULL) - Имя сотрудника.
5. `birth_date` (тип: DATE, NOT NULL) - Дата рождения сотрудника.
6. `specialization_id` (тип: INT, NOT NULL) - Идентификатор специализации сотрудника.
7. `is_active` (тип: BOOLEAN, NOT NULL) - Флаг активности сотрудника.
8. `ch_employee_id` (тип: INT, NOT NULL) - Идентификатор сотрудника, внесшего изменения.
9. `ch_dt` (тип: TIMESTAMPTZ, NOT NULL) - Дата и время внесения изменений.
10. `sync_dt` (тип: TIMESTAMP WITH TIME ZONE, NULL) - Дата и время синхронизации.

## Функция `employeessyncexport`

Функция `employeessyncexport` предназначена для экспорта синхронизированных записей из таблицы `employeessync`.

### Параметры функции

- `_log_id` (тип: BIGINT) - Идентификатор записи синхронизации. Функция будет экспортировать записи, у которых `log_id` меньше или равен указанному `_log_id`.

### Примеры использования функции

```sql
SELECT whsync.employeessyncexport(10000);
```

Пример ответа при правильном выполнении:

```jsonb
{"data" : [{...}, {...}, ...]}
```

В функции `employeessyncexport` происходит удаление записей, у которых указана дата синхронизации (`sync_dt`), и затем происходит экспорт записей с информацией о сотрудниках.

# Функция `employeessyncimport`

## Описание

Функция `whsync.employeessyncimport` предназначена для импорта данных о сотрудниках из JSONB-объекта в таблицу `humanresource.employees`.

## Параметры функции

- `_src` (тип: JSONB) - JSONB-объект, содержащий информацию о сотрудниках, которую необходимо импортировать.

## Примеры использования

```sql

SELECT whsync.employeessyncimport('
[
    {
        "employee_id": 1,
        "phone": "1234567890",
        "name": "Иван Иванов",
        "birth_date": "1990-01-15",
        "specialization_id": 3,
        "is_active": true,
        "ch_employee_id": 2252,
        "ch_dt": "2023-09-11T14:30:00+03:00"
    },
    {
        "employee_id": 2,
        "phone": "9876543210",
        "name": "Петр Петров",
        "birth_date": "1985-05-20",
        "specialization_id": 2,
        "is_active": false,
        "ch_employee_id": 2252,
        "ch_dt": "2023-09-11T15:45:00+03:00"
    }
]
');
```

## Примечания

- Функция выполняет вставку данных из JSONB-объекта в таблицу `humanresource.employees`. Если запись существует (по `employee_id`), она обновляется с учетом даты изменения (`ch_dt`).