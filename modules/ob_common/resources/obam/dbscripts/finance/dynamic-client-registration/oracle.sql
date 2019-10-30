CREATE TABLE OB_DCR_DETAILS (
  ID        VARCHAR2(255)  NOT NULL,
  TPP_NAME VARCHAR2(255) NOT NULL,
  REQUEST_HEADER CLOB NOT NULL,
  REQUEST    CLOB NOT NULL,
  CLIENT_ID VARCHAR2(255) NOT NULL,
  SOFTWARE_ENV VARCHAR2(255) NOT NULL,
  APPLICATION_ID NUMBER(10) NOT NULL,
  SOFTWARE_ID VARCHAR2(255) NOT NULL,
  SPEC_VERSION VARCHAR2(64) NOT NULL,
  CREATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  STATUS VARCHAR2(64) NOT NULL,
  CLID_ISSUED_AT NUMBER(10) NOT NULL,
  STATUS_UPDATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT ENSURE_JSON_REQUEST_HEADER CHECK (REQUEST_HEADER IS JSON),
  CONSTRAINT ENSURE_JSON_REQUEST CHECK (REQUEST IS JSON)
)
