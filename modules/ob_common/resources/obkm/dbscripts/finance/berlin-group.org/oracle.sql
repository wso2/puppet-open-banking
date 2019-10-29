CREATE TABLE BG_PAYMENT_CONSENT (
  PAYMENT_ID                   VARCHAR(255) NOT NULL,
  REQUEST_BODY                 CLOB         NOT NULL,
  PAYMENT_TYPE                 VARCHAR(255) NOT NULL,
  PAYMENT_PRODUCT              VARCHAR(255) NOT NULL,
  REQUEST_INITIATION_TIMESTAMP TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
  TRANSACTION_STATUS           VARCHAR(64)  DEFAULT 0,
  TPP_UNIQUE_ID                VARCHAR(255) NOT NULL,
  X_REQUEST_ID                 VARCHAR(255) NOT NULL,
  PSU_ID                       VARCHAR(255),
  PSU_ID_TYPE                  VARCHAR(255),
  PSU_CORPORATE_ID             VARCHAR(255),
  PSU_CORPORATE_ID_TYPE        VARCHAR(255),
  API_VERSION                  VARCHAR(45)  NOT NULL,
  PRIMARY KEY (PAYMENT_ID)
)
  /

CREATE TABLE BG_PAYMENT_CONSENT_REVOCATION (
  REVOKED_BY           VARCHAR(255)  NOT NULL,
  PAYMENT_ID           VARCHAR(255)  NOT NULL,
  REASON               VARCHAR(1023) NOT NULL,
  REVOCATION_TIMESTAMP TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (REVOKED_BY, PAYMENT_ID),
  FOREIGN KEY (PAYMENT_ID) REFERENCES BG_PAYMENT_CONSENT (PAYMENT_ID)
    ON DELETE CASCADE
)
  /

CREATE TABLE BG_ACCOUNT_INITIALIZATION (
  CONSENT_ID VARCHAR(255)  NOT NULL,
  X_REQUEST_ID VARCHAR(255) NOT NULL,
  PSU_ID VARCHAR(255),
  PSU_ID_TYPE VARCHAR(64),
  PSU_CORPORATE_ID VARCHAR(255),
  PSU_CORPORATE_ID_TYPE VARCHAR(64),
  CONSENT_STATUS VARCHAR(64) DEFAULT 0,
  CONSENT_STATUS_UPDATE_DATETIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  APP_ID INT DEFAULT 0,
  TPP_UNIQUE_ID VARCHAR(255) NOT NULL,
  FREQUENCY_PER_DAY INT NOT NULL,
  API_VERSION VARCHAR(45) NOT NULL,
  PRIMARY KEY (CONSENT_ID)
)
  /

CREATE TABLE BG_ACCOUNT_BINDING (
  CONSENT_ID VARCHAR(255)  NOT NULL,
  ACCOUNT_CONSENT CLOB  NOT NULL,
  RECURRING_INDICATOR GENERATED ALWAYS AS (JSON_VALUE(ACCOUNT_CONSENT, '$.recurringIndicator' RETURNING NUMBER(1))),
  COMBINED_SERVICE_INDICATOR GENERATED ALWAYS AS (JSON_VALUE(ACCOUNT_CONSENT, '$.combinedServiceIndicator' RETURNING NUMBER(1))),
  ACCOUNT_PERMISSIONS VARCHAR(64),
  PRIMARY KEY (CONSENT_ID),
  CONSTRAINT FK_BG_ACCOUNT_BINDING FOREIGN KEY (CONSENT_ID) REFERENCES BG_ACCOUNT_INITIALIZATION (CONSENT_ID) ON DELETE CASCADE
)
  /
CREATE TABLE BG_ACCOUNT_CONSENT_STATUS (
  OLD_STATUS VARCHAR(64) NOT NULL,
  NEW_STATUS VARCHAR(64) NOT NULL,
  ACTION_BY VARCHAR(64) NOT NULL,
  CONSENT_ID VARCHAR(255)  NOT NULL,
  REASON VARCHAR(1023)  NOT NULL,
  ACTION_DATETIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT FK_BG_ACCOUNT_CONSENT_STATUS FOREIGN KEY (CONSENT_ID) REFERENCES BG_ACCOUNT_INITIALIZATION (CONSENT_ID) ON DELETE CASCADE
)
  /
CREATE SEQUENCE consent_id_seq START WITH 1
  /
CREATE TABLE BG_ACCOUNT_CONSENT_FREQUENCY ( USER_ID VARCHAR(255),TPP_UNIQUE_ID VARCHAR(255) NOT NULL,
  CONSENT_ID VARCHAR(255)  NOT NULL,FREQUENCY_PER_DAY INT NOT NULL,
  ID INT DEFAULT consent_id_seq.nextval NOT NULL,PRIMARY KEY (ID)
)
  /

-- TODO: Untested on running system.
-- ACCOUNT ACCESS BINDING
-- FOR BANK OFFERED CONSENT & QUERYING
CREATE TABLE BG_ACCOUNT_ACCESS_BINDING (
  CONSENT_ID VARCHAR(255)  NOT NULL,
  ACCOUNTS CLOB  NOT NULL,
  BALANCES CLOB  NOT NULL,
  TRANSACTIONS CLOB  NOT NULL,
  PRIMARY KEY (CONSENT_ID),
  CONSTRAINT FK_CONSENT_ID_BG_ACCOUNT_ACCESS_BINDING FOREIGN KEY (CONSENT_ID) REFERENCES BG_ACCOUNT_INITIALIZATION (CONSENT_ID)
    ON DELETE CASCADE
)
  /

-- TODO: Untested on running system.
-- AUTHORISATION SUB RESOURCE TABLE
-- BINDS CONSENT TO AUTHORISATION RESOURCE
CREATE TABLE BG_AUTH_RESOURCE (
  -- PRIMARY KEY
  X_REQUEST_ID        VARCHAR(255)  NOT NULL,
  AUTH_TYPE           VARCHAR(255)  NOT NULL,
  CONSENT_ID          VARCHAR(255)  NOT NULL,
  CONSENT_TYPE        VARCHAR(255)  NOT NULL,
  AUTH_ID             VARCHAR(255)  NOT NULL,
  -- USER BINDING
  USER_ID             VARCHAR(255),
  AUTH_STATUS         VARCHAR(255)  NOT NULL,
  -- METADATA
  UPDATED_TIMESTAMP   TIMESTAMP     DEFAULT CURRENT_TIMESTAMP,
  API_VERSION         VARCHAR(255)  NOT NULL,
  -- COMPOSITE CONSTRAINT
  PRIMARY KEY (X_REQUEST_ID, AUTH_TYPE, CONSENT_ID, CONSENT_TYPE, AUTH_ID)
)
  /
-- TODO: Untested on running system.
CREATE TABLE OB_CONSENT_METADATA (
  CONSENT_ID VARCHAR(255) NOT NULL,
  CONSENT_TYPE VARCHAR(255) NOT NULL,
  METADATA_KEY VARCHAR(255) NOT NULL,
  METADATA_VALUE VARCHAR(255) NOT NULL,
  PRIMARY KEY(CONSENT_ID, CONSENT_TYPE, METADATA_KEY)
)
  /
