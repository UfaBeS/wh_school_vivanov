CREATE OR REPLACE FUNCTION humanresource.humanresource_getbyphone(_phone VARCHAR(12)) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT e.employee_id         AS Айди_сотрудника,
                     e.name                AS Имя,
                     e.phone               AS Номер,
                     e.birth_date          AS Дата_рождения,
                     s.specialization_name AS Специализация,
                     p.service_name        AS Услуги,
                     s.skill_lvl           AS Опыт,
                     s.max_queue           AS Очередь
              FROM humanresource.employees e
                       INNER JOIN dictionary.specialization s ON e.specialization_id = s.specialization_id
                       INNER JOIN autoservice.prices p ON s.service_id = p.service_id
              WHERE e.phone = _phone
                AND is_active = true) res;
END
$$;