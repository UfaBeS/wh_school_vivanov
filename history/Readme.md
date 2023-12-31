# Схема `history`
## функция `customerchanges_createpartitions` 
Функия создает партиции для указанной таблицы в соответствии с заданным диапазоном дат. Здесь определены следующие параметры:

- `start_date timestamptz` - дата начала диапазона для создания партиций.
- `end_date timestamptz` - дата окончания диапазона для создания партиций.
- `table_name text` - имя основной таблицы, для которой создаются партиции.

Внутри функции используется цикл `LOOP`, который создает партиции в соответствии с заданным диапазоном дат. Он выполняет следующие действия:

1. `partition_name` инициализируется именем таблицы и месяцем и годом, используя `current_partition_date` и `to_char` для форматирования даты.

2. Внутри цикла выполняется `EXECUTE`, чтобы создать новую партицию. Это делается с использованием SQL-запроса, который создает новую таблицу-партицию для указанного диапазона дат.

3. `current_partition_date` обновляется для следующего месяца.

Цикл завершает выполнение, когда `current_partition_date` достигает или превышает `end_date`.

### Пример использования функции

```sql
SELECT history.create_partitions(now(), (now() + INTERVAL '1 YEAR'), 'customerschanges');
```
В результате создаются партиции для таблицы на год вперёд с текущего момента.

## Функция `customerchanges_deleteoldpartitions`

Функция предназначена для удаления старых партиций в таблице `history.customerschanges`.


### Пример использования функции

```sql
SELECT history.customerchanges_deleteoldpartitions();
```