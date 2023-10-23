CREATE OR REPLACE FUNCTION humanresource.employeesupd(_src JSONB, _ch_employee_id INT) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _employee_id       INT;
    _phone             VARCHAR(11);
    _name              VARCHAR(64);
    _birth_date        DATE;
    _specialization_id INT;
    _is_active         BOOLEAN;
    _ch_dt             TIMESTAMPTZ := now() AT TIME ZONE 'Europe/Moscow';
BEGIN
    SELECT coalesce(s.employee_id, nextval('humanresource.humanresourcesq')) AS employee_id,
           s.phone,
           s.name,
           s.birth_date,
           s.specialization_id,
           s.is_active
    INTO _employee_id, _phone, _name, _birth_date, _specialization_id, _is_active
    FROM jsonb_to_record(_src) AS s (employee_id INT,
                                     phone VARCHAR(11),
                                     name VARCHAR(64),
                                     birth_date DATE,
                                     specialization_id INT,
                                     is_active BOOLEAN);

    INSERT INTO humanresource.employees AS c (employee_id,
                                              phone,
                                              name,
                                              birth_date,
                                              specialization_id,
                                              is_active,
                                              ch_employee_id,
                                              ch_dt)
    SELECT _employee_id,
           _phone,
           _name,
           _birth_date,
           _specialization_id,
           _is_active,
           _ch_employee_id,
           _ch_dt
    ON CONFLICT (employee_id) DO UPDATE
        SET phone             = excluded.phone,
            name              = excluded.name,
            birth_date        = excluded.birth_date,
            specialization_id = excluded.specialization_id,
            is_active         = excluded.is_active;

    INSERT INTO history.employeeschanges (employee_id,
                                          phone,
                                          name,
                                          birth_date,
                                          specialization_id,
                                          is_active,
                                          ch_employee_id,
                                          ch_dt)
    SELECT _employee_id,
           _phone,
           _name,
           _birth_date,
           _specialization_id,
           _is_active,
           _ch_employee_id,
           _ch_dt;

    INSERT INTO whsync.employeessync (employee_id,
                                      phone,
                                      name,
                                      birth_date,
                                      specialization_id,
                                      is_active,
                                      ch_employee_id,
                                      ch_dt)
    SELECT _employee_id,
           _phone,
           _name,
           _birth_date,
           _specialization_id,
           _is_active,
           _ch_employee_id,
           _ch_dt;

    RETURN jsonb_build_object('data', NULL);
END
$$;