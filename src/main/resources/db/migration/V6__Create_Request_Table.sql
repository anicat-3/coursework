CREATE TABLE request
(
    id         BIGINT NOT NULL,
    amount     DECIMAL NOT NULL,
    term       INTEGER NOT NULL,
    rate       FLOAT NOT NULL,
    currency   VARCHAR(15) NOT NULL,
    approved   BOOLEAN,
    date       TIMESTAMP WITHOUT TIME ZONE,
    deposit_id BIGINT NOT NULL,
    user_id    BIGINT NOT NULL,
    CONSTRAINT pk_request PRIMARY KEY (id)
);

ALTER TABLE request
    ADD CONSTRAINT FK_REQUEST_ON_DEPOSITID FOREIGN KEY (deposit_id) REFERENCES deposit (id);

ALTER TABLE request
    ADD CONSTRAINT FK_REQUEST_ON_USERID FOREIGN KEY (user_id) REFERENCES usr (id);