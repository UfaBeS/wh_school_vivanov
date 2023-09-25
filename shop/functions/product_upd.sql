CREATE OR REPLACE FUNCTION shop.product_upd(_data JSON, _employee_id INT) RETURNS JSON
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
           s.naz,
           s.price,
           _dt          AS dt,
           _employee_id AS employee_id
    FROM JSON_TO_RECORDSET(_data) AS s (
                                        id INT,
                                        naz VARCHAR(30),
                                        price NUMERIC(10, 2),
                                        dt TIMESTAMPTZ,
                                        employee_id INT
        );
    SELECT CASE
               WHEN t.employee_id IS NULL THEN 'Не переданы обязательные параметры'
               WHEN t.price <= 0 THEN 'Цена не может быть отрицательной' END
    INTO _err_message
    FROM tmp t;
    IF _err_message IS NOT NULL THEN
        RETURN public.errmessage('product_upd.empty_params_or_p_negative', _err_message, NULL);
    end if;

    IF EXISTS(SELECT 1
              FROM shop.tovar st
                       JOIN tmp t ON (st.id = t.id AND t.naz = st.naz AND t.price=st.price) OR (st.id <> t.id AND t.naz = st.naz)
              )
    THEN
        RETURN public.errmessage('product_upd.duplicate', 'Такая запись уже есть', NULL);
    end if;

    INSERT INTO shop.tovar AS ins (id, naz, price, dt, employee_id)
    SELECT t.id,
           t.naz,
           t.price,
           t.dt,
           t.employee_id
    FROM tmp t
    ON CONFLICT (id) DO UPDATE
        SET naz         = excluded.naz,
            price       = excluded.price,
            employee_id = excluded.employee_id
    WHERE ins.dt < excluded.dt;
    RETURN json_build_object('data', NULL);
END;
$$;

SELECT shop.product_upd('[
  {
    "id": 8,
    "naz": "Продукт6",
    "price": 5
  }
]', 2542);

select * from shop.tovar