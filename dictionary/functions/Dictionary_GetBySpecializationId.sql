CREATE OR REPLACE FUNCTION dictionary.dictionary_getbyspecializationid(_specialization_id INT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT s.specialization_id   AS Айди_специализации,
                     s.specialization_name AS Название_специализации,
                     s.service_id          AS Айди_услуги,
                     s.skill_lvl           AS Уровень_навыка,
                     s.max_queue           AS Макс_очередь
              FROM dictionary.specialization s
              WHERE s.specialization_id = _specialization_id) res;
END
$$;