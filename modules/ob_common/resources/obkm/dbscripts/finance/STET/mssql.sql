CREATE TABLE STET_PAYMENT_CONSENT (
  REQUEST_RESOURCE_ID          VARCHAR(255)   NOT NULL,
  REQUEST_BODY                 NVARCHAR(MAX) NOT NULL CHECK ( ISJSON(REQUEST_BODY) > 0 ),
  X_REQUEST_ID                 VARCHAR(255) NOT NULL,
  REQUEST_INITIATION_TIMESTAMP DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSENT_STATUS               VARCHAR(64)    NOT NULL DEFAULT 0,
  CLIENT_ID                    VARCHAR(255)   NOT NULL,
  PRIMARY KEY (REQUEST_RESOURCE_ID)
);

CREATE TABLE STET_PAYMENT_INSTRUCTION (
  REQUEST_RESOURCE_ID        VARCHAR(255) NOT NULL,
  INSTRUCTION_END_TO_END_ID             VARCHAR(255) NOT NULL,
  INSTRUCTION_STATUS             VARCHAR(64)    NOT NULL DEFAULT 0,
  INSTRUCTION_BODY     NVARCHAR(MAX) NOT NULL CHECK ( ISJSON(INSTRUCTION_BODY) > 0 ),
  PRIMARY KEY (REQUEST_RESOURCE_ID, INSTRUCTION_END_TO_END_ID),
  CONSTRAINT FK_REQUEST_RESOURCE_ID_STET_PAYMENT_INSTRUCTION FOREIGN KEY
  (REQUEST_RESOURCE_ID) REFERENCES STET_PAYMENT_CONSENT (REQUEST_RESOURCE_ID)
    ON DELETE CASCADE
);

CREATE TABLE STET_PAYMENT_CONSENT_USER_MAPPING (
  USER_ID                    VARCHAR(255) NOT NULL,
  REQUEST_RESOURCE_ID        VARCHAR(255) NOT NULL,
  DEBTOR_ACCOUNT             VARCHAR(255),
  UPDATED_TIMESTAMP          DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (USER_ID, REQUEST_RESOURCE_ID),
  CONSTRAINT FK_STET_PAYMENT_CONSENT_USER_MAPPING FOREIGN KEY
  (REQUEST_RESOURCE_ID) REFERENCES STET_PAYMENT_CONSENT (REQUEST_RESOURCE_ID)
    ON DELETE CASCADE
);

CREATE TABLE STET_PAYMENT_CONSENT_REVOCATION_HISTORY (
  REVOKED_BY           VARCHAR(255)  NOT NULL,
  REQUEST_RESOURCE_ID           VARCHAR(255)  NOT NULL,
  INSTRUCTION_END_TO_END_ID             VARCHAR(255) NOT NULL DEFAULT 'ALL',
  REASON               VARCHAR(1000) NOT NULL,
  REVOCATION_TIMESTAMP DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (REVOKED_BY, REQUEST_RESOURCE_ID,INSTRUCTION_END_TO_END_ID),
  CONSTRAINT FK_STET_PAYMENT_CONSENT_REVOCATION_HISTORY FOREIGN KEY
  (REQUEST_RESOURCE_ID) REFERENCES STET_PAYMENT_CONSENT (REQUEST_RESOURCE_ID)
    ON DELETE CASCADE
);

CREATE TABLE STET_ACCOUNT_CONSENT (
    PSU_ID                  VARCHAR(255)    NOT NULL,
    TPP_UNIQUE_ID           VARCHAR(255)    NOT NULL,
    ACCOUNT_CONSENT          NVARCHAR(MAX) NOT NULL CHECK ( ISJSON(ACCOUNT_CONSENT) > 0 ),
    PRIMARY KEY (PSU_ID, TPP_UNIQUE_ID)
);
