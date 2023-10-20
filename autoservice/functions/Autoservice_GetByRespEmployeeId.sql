CREATE OR REPLACE FUNCTION autoservice.autoservice_getbyrespemployeeid(_responsible_employee_id BIGINT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT et.employee_task_id,
                     et.vehicle_id,
                     et.repair_status,
                     et.responsible_employee_id,
                     e.name,
                     e.phone
              FROM autoservice.employeetasks et
                       INNER JOIN humanresource.employees e ON et.responsible_employee_id = e.employee_id
                       INNER JOIN autoservice.orders o on et.vehicle_id = o.vehicle_id
              WHERE et.responsible_employee_id = _responsible_employee_id
                AND o.is_actual = true) res;
END
$$;