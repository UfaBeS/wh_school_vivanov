CREATE OR REPLACE FUNCTION dictionary.specialization_getbyspecializationid(_specialization_id INT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT s.specialization_id,
                     s.specialization_name,
                     s.service_id,
                     s.skill_lvl,
                     s.max_queue
              FROM dictionary.specialization s
              WHERE s.specialization_id = _specialization_id) res;
END
$$;