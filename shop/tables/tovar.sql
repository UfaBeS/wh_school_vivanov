CREATE TABLE tovar
(
    ID    INT            NOT NULL,
    Naz   VARCHAR(30)    NOT NULL,
    Price NUMERIC(10, 2) NOT NULL,
    CONSTRAINT PK_tovar PRIMARY KEY (ID),
    CONSTRAINT ch_price CHECK (Price > 0)
);

ALTER TABLE shop.tovar
    ADD COLUMN dt TIMESTAMPTZ NOT NULL;
ALTER TABLE shop.tovar
    ADD COLUMN employee_id INT NOT NULL;

