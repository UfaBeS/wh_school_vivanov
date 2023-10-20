CREATE OR REPLACE FUNCTION dictionary.specializationupd(_src JSONB) RETURNS JSONB
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _specialization_id   INT;
    _specialization_name VARCHAR(64);
    _service_id          INT;
    _skill_lvl           VARCHAR(6);
    _max_queue           SMALLINT;
BEGIN
    SELECT coalesce(s.specialization_id, nextval('dictionary.specializationsq')) AS specialization_id,
           s.specialization_name,
           s.service_id,
           s.skill_lvl,
           s.max_queue

    INTO _specialization_id, _specialization_name, _service_id, _skill_lvl, _max_queue
    FROM jsonb_to_record(_src) AS s (specialization_id INT,
                                     specialization_name VARCHAR(64),
                                     service_id INT,
                                     skill_lvl VARCHAR(6),
                                     max_queue SMALLINT);

    INSERT INTO dictionary.specialization AS s (specialization_id,
                                                specialization_name,
                                                service_id,
                                                skill_lvl,
                                                max_queue)
    SELECT _specialization_id,
           _specialization_name,
           _service_id,
           _skill_lvl,
           _max_queue
    ON CONFLICT (specialization_id) DO UPDATE
        SET specialization_name = excluded.specialization_name,
            service_id          = excluded.service_id,
            skill_lvl           = excluded.skill_lvl,
            max_queue           = excluded.max_queue;

    RETURN jsonb_build_object('data', NULL);
END
$$;