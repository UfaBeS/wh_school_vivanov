CREATE TABLE IF NOT EXISTS public.autoserviceinfo
(
    setting_id SMALLSERIAL  NOT NULL
        CONSTRAINT pk_autoserviceinfo PRIMARY KEY,
    name       VARCHAR(32)  NOT NULL,
    value      VARCHAR(500) NULL
);
