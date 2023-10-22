CREATE OR REPLACE FUNCTION humanresource.employees_getbyphone(_phone VARCHAR(11) DEFAULT NULL) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT e.employee_id,
                     e.name,
                     e.phone,
                     e.birth_date,
                     s.specialization_name,
                     p.service_name,
                     s.skill_lvl,
                     s.max_queue
              FROM humanresource.employees e
                       INNER JOIN dictionary.specialization s ON e.specialization_id = s.specialization_id
                       INNER JOIN autoservice.prices p ON s.service_id = p.service_id
              WHERE (_phone IS NULL OR e.phone = _phone)
                AND is_active = true) res;
END
$$;
