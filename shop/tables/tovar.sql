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

INSERT INTO shop.tovar
VALUES (1, 'Продукт1', 50, now(), 2542),
       (2, 'Продукт2', 75, now(), 2542),
       (3, 'Продукт3', 150, now(), 2542),
       (4, 'Продукт4', 100, now(), 2542),
       (5, 'Продукт5', 200, now(), 2542);