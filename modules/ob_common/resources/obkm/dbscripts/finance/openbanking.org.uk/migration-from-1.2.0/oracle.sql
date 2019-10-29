CREATE TABLE UK_COF_INITIATION (
  ID        VARCHAR2(255)  NOT NULL,
  REQUEST    CLOB NOT NULL,
  CREATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  STATUS    VARCHAR2(64)   NOT NULL,
  CLIENT_ID VARCHAR2(255)  NOT NULL,
  STATUS_UPDATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  SPEC_VERSION VARCHAR2(64)   NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT ENSURE_JSON_REQUEST_FUNDS_CONF CHECK (REQUEST IS JSON)
)
/
CREATE TABLE UK_COF_CONSENT_BINDING (
  USER_ID           VARCHAR2(255) NOT NULL,
  CONSENT_ID        VARCHAR2(255) NOT NULL,
  ACCOUNT_ID        VARCHAR2(255) NOT NULL,
  TIMESTAMP         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  COLLECTION_METHOD VARCHAR2(64),
  PRIMARY KEY (USER_ID, CONSENT_ID,ACCOUNT_ID),
  CONSTRAINT FK_COF_CONSENT_BINDING FOREIGN KEY (CONSENT_ID) REFERENCES UK_COF_INITIATION (ID)
    ON DELETE CASCADE
)
/
CREATE TABLE UK_TRANSACTION_FILE (
  CONSENT_ID        VARCHAR(255) NOT NULL,
  CLIENT_ID         VARCHAR(255) NOT NULL,
  PAYMENT_FILE      CLOB   NOT NULL,
  IDEMPOTENT_KEY    VARCHAR(64)  NOT NULL,
  TIMESTAMP         TIMESTAMP    DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (CONSENT_ID),
  CONSTRAINT FK_TRANSACTION_FILE FOREIGN KEY (CONSENT_ID) REFERENCES UK_TRANSACTION_INITIATION (ID)
      ON DELETE CASCADE
)
/
CREATE TABLE UK_COF_CONSENT_REV_HISTORY (
  CONSENT_ID VARCHAR2(255) NOT NULL,
  REVOCATION_USER VARCHAR2(255) NOT NULL,
  REVOCATION_REASON VARCHAR2(2048) NOT NULL,
  PRIMARY KEY (CONSENT_ID),
  CONSTRAINT FK_COF_REVOCATION_HISTORY FOREIGN KEY (CONSENT_ID) REFERENCES UK_COF_INITIATION (ID)
    ON DELETE CASCADE
)
/
CREATE TABLE OB_MULTI_AUTHORIZATION (
  ID  INT,
  CONSENT_ID VARCHAR2(255) NOT NULL,
  CLIENT_ID  VARCHAR2(255) NOT NULL,
  SELECTED_ACCOUNT  VARCHAR2(255) NOT NULL,
  AUTHORIZATION_EXPIRY_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  STATUS VARCHAR2(255) NOT NULL,
  NUMBER_OF_TOTAL_AUTHORIZATIONS INTEGER DEFAULT 0,
  CREATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  STATUS_UPDATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT OB_MULTI_AUTH_SEQUENCE PRIMARY KEY (ID)
)
/
CREATE SEQUENCE OB_MULTI_AUTH_SEQUENCE START WITH 1 INCREMENT BY 1 NOCACHE
/
CREATE OR REPLACE TRIGGER MULTI_AUTHORIZATION_TRIGGER
                    BEFORE INSERT
                    ON OB_MULTI_AUTHORIZATION
                    FOR EACH ROW
                     BEGIN
                       SELECT OB_MULTI_AUTH_SEQUENCE.nextval INTO :NEW.ID FROM dual;
           		       END;
/
CREATE TABLE OB_MULTI_AUTHORIZATION_USER (
  ID  INTEGER DEFAULT 0,
  USER_ID VARCHAR2(255) NOT NULL,
  STATUS  VARCHAR2(255) NOT NULL,
  CREATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  CONSTRAINT PK_OB_MULTI_AUTHORIZATION_USER PRIMARY KEY(ID,USER_ID) ,
  CONSTRAINT FK_ID_OB_MULTI_AUTH_USER  FOREIGN KEY (ID) REFERENCES OB_MULTI_AUTHORIZATION (ID)
    ON DELETE CASCADE
)
/
CREATE TABLE UK_CONSENT_REV (
  USER_ID           VARCHAR2(255) NOT NULL,
  CONSENT_ID        VARCHAR2(255) NOT NULL,
  ACCOUNT_ID        VARCHAR2(255) NOT NULL,
  TIMESTAMP         TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  COLLECTION_METHOD VARCHAR2(64),
  PRIMARY KEY (USER_ID, CONSENT_ID,ACCOUNT_ID)
)
/
CREATE TABLE OB_CONSENT_METADATA (
  CONSENT_ID VARCHAR(255) NOT NULL,
  CONSENT_TYPE VARCHAR(255) NOT NULL,
  METADATA_KEY VARCHAR(255) NOT NULL,
  METADATA_VALUE VARCHAR(255) NOT NULL,
  PRIMARY KEY(CONSENT_ID, CONSENT_TYPE, METADATA_KEY),
  CONSTRAINT FK_CONSENT_ID_UK_INITIATION FOREIGN KEY (CONSENT_ID) REFERENCES UK_TRANSACTION_INITIATION (ID)
  ON DELETE CASCADE
)
/
CREATE TABLE OB_DCR_DETAILS (
  ID        VARCHAR2(255)  NOT NULL,
  TPP_NAME VARCHAR2(255) NOT NULL,
  REQUEST_HEADER CLOB NOT NULL,
  REQUEST    CLOB NOT NULL,
  CLIENT_ID VARCHAR2(255) NOT NULL,
  SOFTWARE_ENV VARCHAR2(255) NOT NULL,
  SPEC_VERSION VARCHAR2(64) NOT NULL,
  CREATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  STATUS VARCHAR2(64) NOT NULL,
  STATUS_UPDATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  PRIMARY KEY (ID),
  CONSTRAINT ENSURE_JSON_REQUEST_HEADER CHECK (REQUEST_HEADER IS JSON),
  CONSTRAINT ENSURE_JSON_REQUEST CHECK (REQUEST IS JSON)
)
/
CREATE SEQUENCE callback_seq START WITH 1;
/
CREATE TABLE UK_NOTIFICATION_CALLBACK (
  ID NUMBER(10) DEFAULT callback_seq.nextval NOT NULL,
  CLIENT_ID VARCHAR2(50) NOT NULL,
  REQUEST CLOB NOT NULL,
  TIMESTAMP timestamp NULL,
  SPEC_VERSION VARCHAR2(10) NOT NULL,
  CONSTRAINT callback_pk PRIMARY KEY (ID),
  CONSTRAINT ENSURE_JSON_REQUEST_CALLBACK CHECK (REQUEST IS JSON)
)
/
CREATE SEQUENCE notif_seq START WITH 1;
/
CREATE TABLE UK_NOTIFICATION (
  ID NUMBER(10) DEFAULT notif_seq.nextval NOT NULL,
  RESOURCE_ID VARCHAR2(50) NOT NULL,
  RESOURCE_TYPE VARCHAR2(50) NOT NULL,
  RESOURCE_LINK VARCHAR2(200) NOT NULL,
  VERSION VARCHAR2(10) NOT NULL,
  CLIENT_ID VARCHAR2(50) NOT NULL,
  STATUS VARCHAR2(10) NOT NULL,
  TIMESTAMP timestamp NULL,
  LAST_RETRY_TIME timestamp NULL,
  NEXT_RETRY_TIME timestamp NULL,
  TRY_COUNT NUMBER(10) NOT NULL,
  CONSTRAINT notif_pk PRIMARY KEY (ID)
)
/
DECLARE
  sut_column_exists number := 0;  
BEGIN
  Select count(*) into sut_column_exists
    from user_tab_cols
    where upper(column_name) = 'STATUS_UPDATED_TIMESTAMP'
      and upper(table_name) = 'UK_TRANSACTION_INITIATION';

  if (sut_column_exists = 0) then
      EXECUTE IMMEDIATE 'ALTER TABLE UK_TRANSACTION_INITIATION ADD STATUS_UPDATED_TIMESTAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL';
      EXECUTE IMMEDIATE 'ALTER TABLE UK_TRANSACTION_INITIATION ADD SPEC_VERSION VARCHAR2(64) DEFAULT ''UK200'' NOT NULL';
  end if;
end;
/
DECLARE
  sv_column_exists number := 0;  
BEGIN
  Select count(*) into sv_column_exists
    from user_tab_cols
    where upper(column_name) = 'SPEC_VERSION'
      and upper(table_name) = 'UK_ACCOUNT_INITIATION';

  if (sv_column_exists = 0) then
      EXECUTE IMMEDIATE 'ALTER TABLE UK_ACCOUNT_INITIATION ADD SPEC_VERSION VARCHAR2(64) DEFAULT ''UK200'' NOT NULL';
  end if;
end;
/
DECLARE
  url_column_exists number := 0;
BEGIN
  Select count(*) into url_column_exists
    from user_tab_cols
    where upper(column_name) = 'URL'
      and upper(table_name) = 'UK_NOTIFICATION_CALLBACK';

  if (url_column_exists = 1) then
      EXECUTE IMMEDIATE 'ALTER TABLE UK_NOTIFICATION_CALLBACK ADD SPEC_VERSION VARCHAR(10) DEFAULT ''UK300'' NOT NULL';
      EXECUTE IMMEDIATE 'ALTER TABLE UK_NOTIFICATION_CALLBACK ADD REQUEST CLOB DEFAULT ''{}'' NOT NULL';
      EXECUTE IMMEDIATE 'ALTER TABLE UK_NOTIFICATION_CALLBACK ADD CONSTRAINT ENSURE_JSON_REQUEST_CALLBACK CHECK (REQUEST IS JSON)';
      EXECUTE IMMEDIATE 'UPDATE UK_NOTIFICATION_CALLBACK a SET (REQUEST) = (SELECT JSON_OBJECT(''CallbackUrlId'' VALUE ID, ''Url'' VALUE URL, ''Version'' VALUE VERSION ABSENT ON NULL) FROM UK_NOTIFICATION_CALLBACK b WHERE a.id = b.id)';
  end if;
end;
/
DECLARE
  spec_column_exists number := 0;
BEGIN
  Select count(*) into spec_column_exists
    from user_tab_cols
    where upper(column_name) = 'SPEC_VERSION'
      and upper(table_name) = 'UK_COF_INITIATION';

  if (spec_column_exists = 0) then
      EXECUTE IMMEDIATE 'ALTER TABLE UK_COF_INITIATION ADD SPEC_VERSION VARCHAR(10) DEFAULT ''UK300'' NOT NULL';
  end if;
end;
/
