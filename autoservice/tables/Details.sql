CREATE TABLE IF NOT EXISTS autoservice.details
(
    detail_id   BIGINT       NOT NULL
        CONSTRAINT pk_details PRIMARY KEY,
    detail_name VARCHAR(500) NOT NULL,
    brand_id    SMALLINT     NOT NULL,
    model       VARCHAR(50)  NOT NULL
);