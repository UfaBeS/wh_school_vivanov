CREATE OR REPLACE FUNCTION autoservice.autoservice_getbyrespemployeeid(_responsible_employee_id BIGINT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT et.employee_task_id        AS Айди_заказа,
                     et.vehicle_id              AS Айди_машины,
                     et.repair_status           AS Статус_ремонта,
                     et.responsible_employee_id AS Ответственный,
                     e.name                     AS Имя,
                     e.phone                    AS Телефон
              FROM autoservice.employeetasks et
                       INNER JOIN humanresource.employees e ON et.responsible_employee_id = e.employee_id
              WHERE et.responsible_employee_id = _responsible_employee_id) res;
END
$$;