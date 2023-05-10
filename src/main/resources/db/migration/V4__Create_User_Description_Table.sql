CREATE TABLE usr_description
(
    id                   BIGINT NOT NULL,
    usr_id               BIGINT NOT NULL,
    surname              VARCHAR(50) NOT NULL ,
    name                 VARCHAR(50) NOT NULL,
    patronymic           VARCHAR(50),
    dob                  TIMESTAMP WITHOUT TIME ZONE,
    passport_series      VARCHAR(3) NOT NULL,
    passport_number      VARCHAR(8) NOT NULL,
    passport_id          VARCHAR(15) NOT NULL,
    passport_issued_by   VARCHAR(255) NOT NULL,
    passport_issued_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    citizenship          VARCHAR(50) NOT NULL,
    CONSTRAINT pk_usr_description PRIMARY KEY (id)
);

ALTER TABLE usr_description
    ADD CONSTRAINT FK_USR_DESCRIPTION_ON_USR FOREIGN KEY (usr_id) REFERENCES usr (id);