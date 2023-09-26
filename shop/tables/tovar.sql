CREATE TABLE shop.tovar
(
    id    INT            NOT NULL,
    naz   VARCHAR(30)    NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    dt TIMESTAMPTZ NOT NULL,
    employee_id INT NOT NULL,
    CONSTRAINT PK_tovar PRIMARY KEY (id),
    CONSTRAINT ch_price CHECK (price > 0)
);

