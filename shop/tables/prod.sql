CREATE TABLE shop.prod
(
    ID    INT       not null,
    Dt    timestamp not null,
    Cl_id INT       not null,
    T_id  INT       not null,
    Kol   INT       NOT NULL,
    CONSTRAINT PK_prod PRIMARY KEY (ID),
    CONSTRAINT ch_kol CHECK ( Kol > 0 )
);
