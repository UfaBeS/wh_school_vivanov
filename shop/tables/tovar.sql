CREATE TABLE shop.tovar
(
    ID    INT            NOT NULL,
    Naz   VARCHAR(30)    NOT NULL,
    Price NUMERIC(10, 2) NOT NULL,
    dt TIMESTAMPTZ NOT NULL,
    employee_id INT NOT NULL,
    CONSTRAINT PK_tovar PRIMARY KEY (ID),
    CONSTRAINT ch_price CHECK (Price > 0)
);

