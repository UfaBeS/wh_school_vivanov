CREATE OR REPLACE FUNCTION whsync.employeessyncimport(_src JSONB) RETURNS JSONB
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    INSERT INTO humanresource.employees AS e (employee_id,
                                              phone,
                                              name,
                                              birth_date,
                                              specialization_id,
                                              is_active,
                                              ch_employee_id,
                                              ch_dt)
    SELECT s.employee_id,
           s.phone,
           s.name,
           s.birth_date,
           s.specialization_id,
           s.is_active,
           s.ch_employee_id,
           s.ch_dt
    FROM jsonb_to_recordset(_src) AS s (employee_id BIGINT,
                                        phone VARCHAR(12),
                                        name VARCHAR(64),
                                        birth_date DATE,
                                        specialization_id INT,
                                        is_active BOOLEAN,
                                        ch_employee_id INT,
                                        ch_dt TIMESTAMPTZ)
    ON CONFLICT (employee_id) DO UPDATE
        SET phone             = excluded.phone,
            name              = excluded.name,
            birth_date        = excluded.birth_date,
            specialization_id = excluded.specialization_id,
            is_active         = excluded.is_active,
            ch_employee_id    = excluded.ch_employee_id,
            ch_dt             = excluded.ch_dt
    WHERE e.ch_dt < excluded.ch_dt;

    RETURN JSONB_BUILD_OBJECT('data', NULL);
END
$$;

CREATE OR REPLACE FUNCTION whsync.clientcard_import(_src jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    WITH cte AS (SELECT j.card_id,
                        j.client_id,
                        j.is_deleted,
                        j.dt,
                        j.employee_id,
                        ROW_NUMBER() OVER (PARTITION BY j.card_id ORDER BY j.dt DESC) rn
                 FROM jsonb_to_recordset(_src) AS j (card_id INT,
                                                     client_id INT,
                                                     is_deleted BOOLEAN,
                                                     dt TIMESTAMPTZ,
                                                     employee_id INT))

    INSERT INTO shop.clientcard AS cc (card_id,
                                       client_id,
                                       is_deleted,
                                       dt,
                                       employee_id)
    SELECT c.card_id,
           c.client_id,
           c.is_deleted,
           c.dt,
           c.employee_id
    FROM cte c
    WHERE c.rn = 1
    ON CONFLICT (card_id) DO UPDATE
        SET client_id   = excluded.client_id,
            is_deleted  = excluded.is_deleted,
            dt          = excluded.dt,
            employee_id = excluded.employee_id
    WHERE cc.dt <= excluded.dt; --если проливка данных

    RETURN jsonb_build_object('data', NULL);
END
$$;