CREATE TABLE deposit
(
    id             BIGINT       NOT NULL,
    name           VARCHAR(255) NOT NULL,
    type           VARCHAR(30)  NOT NULL,
    interest_rate  FLOAT        NOT NULL,
    amount_min     DECIMAL,
    term_min       INTEGER,
    term_max       INTEGER,
    CONSTRAINT pk_deposit PRIMARY KEY (id)
);

CREATE TABLE currency
(
    currency   VARCHAR(50) NOT NULL,
    deposit_id BIGINT      NOT NULL
);

ALTER TABLE currency
    ADD CONSTRAINT FK_CURRENCY_ON_DEPOSIT FOREIGN KEY (deposit_id) REFERENCES deposit (id);