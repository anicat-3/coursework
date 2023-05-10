CREATE TABLE account
(
    id             BIGINT NOT NULL,
    contract_id    BIGINT,
    amount         DECIMAL NOT NULL,
    account_number VARCHAR(255),
    CONSTRAINT pk_account PRIMARY KEY (id)
);

ALTER TABLE account
    ADD CONSTRAINT FK_ACCOUNT_ON_CONTRACTID FOREIGN KEY (contract_id) REFERENCES contract (id);