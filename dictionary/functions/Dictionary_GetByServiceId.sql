CREATE OR REPLACE FUNCTION dictionary.dictionary_getbyserviceid(_service_id INT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT s.service_id  AS Айди,
                     s.type_car_id AS Айди_типа_авто,
                     s.detail_id   AS Айди_детали,
                     d.detail_name AS Название_детали
              FROM dictionary.servicedetails s
                       INNER JOIN autoservice.details d ON s.detail_id = d.detail_id
              WHERE s.service_id = _service_id) res;
END
$$;