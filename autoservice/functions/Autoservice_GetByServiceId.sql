CREATE OR REPLACE FUNCTION autoservice.autoservice_getbyserviceid(_service_id INT) RETURNS jsonb
    LANGUAGE plpgsql
    SECURITY DEFINER
AS
$$
BEGIN
    RETURN jsonb_build_object('data', jsonb_agg(row_to_json(res)))
        FROM (SELECT s.service_id,
                     p.service_name,
                     p.price,
                     p.work_time,
                     s.type_car_id,
                     s.detail_id,
                     d.detail_name
              FROM dictionary.servicedetails s
                       INNER JOIN autoservice.details d ON s.detail_id = d.detail_id
                       INNER JOIN autoservice.prices p ON s.service_id = p.service_id
              WHERE s.service_id = _service_id) res;
END
$$;