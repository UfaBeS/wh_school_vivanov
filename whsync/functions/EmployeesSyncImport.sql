CREATE OR REPLACE FUNCTION whsync.employeessyncimport(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    WITH cte AS (SELECT s.employee_id,
                        s.phone,
                        s.name,
                        s.birth_date,
                        s.specialization_id,
                        s.is_active,
                        s.ch_employee_id,
                        s.ch_dt,
                        ROW_NUMBER() OVER (PARTITION BY s.employee_id ORDER BY s.ch_dt DESC) rn
                 FROM jsonb_to_recordset(_src) AS s (employee_id BIGINT,
                                                     phone VARCHAR(11),
                                                     name VARCHAR(64),
                                                     birth_date DATE,
                                                     specialization_id INT,
                                                     is_active BOOLEAN,
                                                     ch_employee_id INT,
                                                     ch_dt TIMESTAMPTZ))

    INSERT
    INTO humanresource.employees AS e (employee_id,
                                       phone,
                                       name,
                                       birth_date,
                                       specialization_id,
                                       is_active,
                                       ch_employee_id,
                                       ch_dt)
    SELECT c.employee_id,
           c.phone,
           c.name,
           c.birth_date,
           c.specialization_id,
           c.is_active,
           c.ch_employee_id,
           c.ch_dt
    FROM cte c
    WHERE c.rn = 1
    ON CONFLICT (employee_id) DO UPDATE
        SET phone             = excluded.phone,
            name              = excluded.name,
            birth_date        = excluded.birth_date,
            specialization_id = excluded.specialization_id,
            is_active         = excluded.is_active,
            ch_employee_id    = excluded.ch_employee_id,
            ch_dt             = excluded.ch_dt
    WHERE e.ch_dt <= excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;
