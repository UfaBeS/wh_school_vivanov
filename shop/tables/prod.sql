CREATE TABLE shop.prod
(
    id    INT       not null,
    dt    timestamp not null,
    cl_id INT       not null,
    t_id  INT       not null,
    kol   INT       NOT NULL,
    CONSTRAINT PK_prod PRIMARY KEY (id),
    CONSTRAINT ch_kol CHECK (kol > 0 )
);
