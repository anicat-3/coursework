CREATE TABLE contract
(
    id               BIGINT NOT NULL,
    request_id       BIGINT NOT NULL,
    personal_account VARCHAR(255),
    type             VARCHAR(10),
    date_opened      TIMESTAMP WITHOUT TIME ZONE,
    date_closed      TIMESTAMP WITHOUT TIME ZONE,
    opened           BOOLEAN NOT NULL,
    last_balanced    TIMESTAMP WITHOUT TIME ZONE,
    amount_balanced  DECIMAL,
    CONSTRAINT pk_contract PRIMARY KEY (id)
);

ALTER TABLE contract
    ADD CONSTRAINT FK_CONTRACT_ON_REQUESTID FOREIGN KEY (request_id) REFERENCES request (id);