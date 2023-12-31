
# Схема `humanresource`

## Таблица `employees`

### Структура таблицы

1. `employee_id` (тип: INT, NOT NULL) - Уникальный идентификатор сотрудника. Первичный ключ таблицы.
2. `phone` (тип: VARCHAR(11), NOT NULL) - Номер телефона сотрудника.
3. `name` (тип: VARCHAR(64), NOT NULL) - Имя сотрудника.
4. `birth_date` (тип: DATE, NOT NULL) - Дата рождения сотрудника.
5. `specialization_id` (тип: INT, NOT NULL) - Идентификатор специализации сотрудника.
6. `is_active` (тип: BOOLEAN, NOT NULL) - Флаг активности сотрудника.
7. `ch_employee_id` (тип: INT, NOT NULL) - Идентификатор сотрудника, внесшего изменения.
8. `ch_dt` (тип: TIMESTAMPTZ, NOT NULL) - Дата и время внесения изменений.

### Функция `employeesupd`

Функция `employeesupd` предназначена для добавления или обновления записей в таблице `employees`.

### Параметры функции

- `_src` (тип: JSONB) - JSON-объект, содержащий информацию о сотруднике. Может включать следующие поля:
    - `employee_id` (тип: INT) - Уникальный идентификатор сотрудника. Если не указан, то будет создан новый.
    - `phone` (тип: VARCHAR(11)) - Номер телефона сотрудника.
    - `name` (тип: VARCHAR(64)) - Имя сотрудника.
    - `birth_date` (тип: DATE) - Дата рождения сотрудника.
    - `specialization_id` (тип: INT) - Идентификатор специализации сотрудника.
    - `is_active` (тип: BOOLEAN) - Флаг активности сотрудника.

### Примеры использования функции

1. Добавление нового сотрудника:

   ```sql
   SELECT humanresource.employeesupd('
   {
       "name": "Иван Иванов",
       "phone": "9876543210",
       "birth_date": "1990-05-15",
       "specialization_id": 3,
       "is_active": true
   }', 2252);
   ```

   Пример ответа при правильном выполнении:

   ```jsonb
   {"data": null}
   ```

2. Обновление существующего сотрудника (по `employee_id`):

   ```sql
   SELECT humanresource.employeesupd('
   {
       "employee_id": 1,
       "name": "Иван Иванов",
       "phone": "9876543210",
       "birth_date": "1990-05-15",      
       "specialization_id": 2,
       "is_active": false
   }', 2252);
   ```
   Пример ответа при правильном выполнении:

   ```jsonb
   {"data": null}
   ```
# Функция `employees_getbyphone`

Функция предназначена для получения информации о сотруднике на основе его номера телефона.

### Параметры функции

- `_phone` (тип: VARCHAR(11)) - Номер телефона сотрудника, по которому требуется получить информацию.

### Пример использования функции

Для получения информации о сотруднике по его номеру телефона, выполните следующий запрос:

```sql
SELECT * FROM humanresource.employees_getbyphone('1234567890');
```

Пример ответа при правильном выполнении:

```jsonb
{
  "data": [
    {
      "employee_id": 1,
      "name": "Иван Иванов",
      "phone": "1234567890",
      "birth_date": "1990-01-15",
      "specialization_name": "Механик",
      "service_name": "Ремонт двигателя",
      "skill_lvl": 2,
      "max_queue": 3
    }
  ]
}

```