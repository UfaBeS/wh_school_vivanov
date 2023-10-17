CREATE OR REPLACE FUNCTION autoservice.employeetasksupd(_src JSONB, _ch_employee_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _employee_task_id        BIGINT;
    _repair_status           VARCHAR(20);
    _responsible_employee_id INT;
    _ch_dt                   TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT coalesce(s.employee_task_id, nextval('autoservice.autoservicesq')) AS employee_task_id,
           s.repair_status,
           s.responsible_employee_id
    INTO _employee_task_id, _repair_status, _responsible_employee_id
    FROM jsonb_to_record(_src) AS s (employee_task_id BIGINT,
                                     repair_status VARCHAR(20),
                                     responsible_employee_id INT);

    INSERT INTO autoservice.employeetasks AS c (employee_task_id,
                                                repair_status,
                                                responsible_employee_id,
                                                ch_employee_id,
                                                ch_dt)
    SELECT _employee_task_id,
           _repair_status,
           _responsible_employee_id,
           _ch_employee_id,
           _ch_dt
    ON CONFLICT (employee_task_id) DO UPDATE
        SET repair_status           = excluded.repair_status,
            responsible_employee_id = excluded.responsible_employee_id;


    RETURN jsonb_build_object('data', NULL);
END
$$;