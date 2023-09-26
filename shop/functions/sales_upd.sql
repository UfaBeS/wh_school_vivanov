CREATE OR REPLACE FUNCTION shop.sales_upd(_data JSON, _cl_id INT) RETURNS JSON
    SECURITY DEFINER
    LANGUAGE plpgsql
AS
$$
DECLARE
    _dt          TIMESTAMPTZ = NOW();
    _err_message VARCHAR(500);
BEGIN
    CREATE TEMP TABLE tmp ON COMMIT DROP AS
    SELECT s.id,
           _dt AS dt,
           _cl_id AS cl_id,
           s.t_id,
           s.kol
    FROM JSON_TO_RECORDSET(_data) AS s (
                                        id INT,
                                        dt TIMESTAMPTZ,
                                        cl_id INT,
                                        t_id INT,
                                        kol INT
        );
    SELECT CASE
               WHEN t.cl_id IS NULL THEN 'Не переданы обязательные параметры (id клиента)'
               WHEN t.t_id IS NULL THEN 'Не переданы обязательные параметры (id товара)'
               WHEN t.kol <= 0 THEN 'Количество не может быть отрицательным' END
    INTO _err_message
    FROM tmp t;
    IF _err_message IS NOT NULL THEN
        RETURN public.errmessage('product_upd.empty_params_or_p_negative', _err_message, NULL);
    end if;

    IF EXISTS(SELECT 1
              FROM shop.prod p
                       JOIN tmp t ON (p.id = t.id AND t.cl_id = p.cl_id AND t.t_id = p.t_id)
              )
    THEN
        RETURN public.errmessage('product_upd.duplicate', 'Такая запись уже есть', NULL);
    end if;

    INSERT INTO shop.prod AS ins (id,dt,cl_id,t_id,kol)
    SELECT t.id,
           t.dt,
           t.cl_id,
           t.t_id,
           t.kol
    FROM tmp t
    ON CONFLICT (id) DO UPDATE
        SET cl_id         = excluded.cl_id,
            t_id       = excluded.t_id,
            kol = excluded.kol
    WHERE ins.dt < excluded.dt;
    RETURN json_build_object('data', NULL);
END;
$$;

