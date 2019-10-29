IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[UK_COF_INITIATION]') AND TYPE IN (N'U'))
CREATE TABLE UK_COF_INITIATION (
  ID        VARCHAR(255)  NOT NULL,
  REQUEST   NVARCHAR(MAX) NOT NULL CHECK ( ISJSON(REQUEST) > 0 ),
  CREATED_TIMESTAMP DATETIME      NOT NULL DEFAULT getdate(),
  STATUS    VARCHAR(64)   NOT NULL DEFAULT 0,
  CLIENT_ID VARCHAR(255)  NOT NULL,
  STATUS_UPDATED_TIMESTAMP DATETIME      NOT NULL DEFAULT getdate(),
  SPEC_VERSION VARCHAR(64)   NOT NULL,
  PRIMARY KEY (ID),
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[UK_TRANSACTION_FILE]') AND TYPE IN (N'U'))
CREATE TABLE UK_TRANSACTION_FILE (
  CONSENT_ID        VARCHAR(255) NOT NULL,
  CLIENT_ID         VARCHAR(255) NOT NULL,
  PAYMENT_FILE      XML   NOT NULL,
  IDEMPOTENT_KEY    VARCHAR(64)  NOT NULL,
  TIMESTAMP         DATETIME     NOT NULL DEFAULT getdate(),
  PRIMARY KEY (CONSENT_ID),
  CONSTRAINT FK_CONSENT_ID_UK_TRANSACTION_FILE FOREIGN KEY (CONSENT_ID) REFERENCES UK_TRANSACTION_INITIATION (ID)
      ON DELETE CASCADE
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[UK_COF_CONSENT_BINDING]') AND TYPE IN (N'U'))
CREATE TABLE UK_COF_CONSENT_BINDING (
  USER_ID           VARCHAR(255) NOT NULL,
  CONSENT_ID        VARCHAR(255) NOT NULL,
  ACCOUNT_ID        VARCHAR(255) NOT NULL,
  TIMESTAMP         DATETIME     NOT NULL DEFAULT getdate(),
  COLLECTION_METHOD VARCHAR(64),
  PRIMARY KEY (USER_ID, CONSENT_ID,ACCOUNT_ID),
  CONSTRAINT FK_CONSENT_ID_UK_COF_CONSENT_BINDING FOREIGN KEY (CONSENT_ID) REFERENCES UK_COF_INITIATION (ID)
    ON DELETE CASCADE
);

EXEC sp_rename 'UK_ACCOUNT_CONSENT_REVOCATION_HISTORY', 'UK_ACCOUNT_CONSENT_REV_HISTORY'
GO

ALTER TABLE UK_ACCOUNT_CONSENT_REV_HISTORY ALTER COLUMN REVOCATION_REASON VARCHAR(2048);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[UK_COF_CONSENT_REV_HISTORY]') AND TYPE IN (N'U'))
CREATE TABLE UK_COF_CONSENT_REV_HISTORY (
  CONSENT_ID VARCHAR(255) NOT NULL,
  REVOCATION_USER VARCHAR(255) NOT NULL,
  REVOCATION_REASON VARCHAR(2048) NOT NULL,
  PRIMARY KEY (CONSENT_ID),
  CONSTRAINT FK_CONSENT_ID_UK_FUNDS_CONFIRMATION_CONSENT_REVOCATION_HISTORY FOREIGN KEY (CONSENT_ID) REFERENCES UK_COF_INITIATION (ID)
    ON DELETE CASCADE
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[OB_MULTI_AUTHORIZATION]') AND TYPE IN (N'U'))
CREATE TABLE OB_MULTI_AUTHORIZATION (
  ID        INTEGER IDENTITY(1,1) NOT NULL,
  CONSENT_ID        VARCHAR(255)  NOT NULL,
  CLIENT_ID         VARCHAR(255)  NOT NULL,
  SELECTED_ACCOUNT  VARCHAR(255)  NOT NULL,
  STATUS        VARCHAR(255)  NOT NULL,
  NUMBER_OF_TOTAL_AUTHORIZATIONS INTEGER DEFAULT 0,
  AUTHORIZATION_EXPIRY_DATE DATETIME NOT NULL,
  CREATED_TIMESTAMP DATETIME      NOT NULL DEFAULT getdate(),
  STATUS_UPDATED_TIMESTAMP DATETIME      NOT NULL DEFAULT getdate(),
  PRIMARY KEY (ID)
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[OB_MULTI_AUTHORIZATION_USER]') AND TYPE IN (N'U'))
CREATE TABLE OB_MULTI_AUTHORIZATION_USER (
  ID        INTEGER DEFAULT 0,
  USER_ID        VARCHAR(255)  NOT NULL,
  STATUS        VARCHAR(255)  NOT NULL,
  CREATED_TIMESTAMP DATETIME      NOT NULL DEFAULT getdate(),
  PRIMARY KEY (ID,USER_ID),
  CONSTRAINT FK_ID_OB_MULTI_AUTHORIZATION_USER FOREIGN KEY (ID) REFERENCES OB_MULTI_AUTHORIZATION (ID)
    ON DELETE CASCADE
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[UK_CONSENT_REV]') AND TYPE IN (N'U'))
CREATE TABLE UK_CONSENT_REV (
  USER_ID           VARCHAR(255) NOT NULL,
  CONSENT_ID        VARCHAR(255) NOT NULL,
  ACCOUNT_ID        VARCHAR(255) NOT NULL,
  TIMESTAMP         DATETIME     NOT NULL DEFAULT getdate(),
  COLLECTION_METHOD VARCHAR(64),
  PRIMARY KEY (USER_ID, CONSENT_ID,ACCOUNT_ID)
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[OB_CONSENT_METADATA]') AND TYPE IN (N'U'))
CREATE TABLE OB_CONSENT_METADATA (
  CONSENT_ID VARCHAR(255) NOT NULL,
  CONSENT_TYPE VARCHAR(255) NOT NULL,
  METADATA_KEY VARCHAR(255) NOT NULL,
  METADATA_VALUE VARCHAR(255) NOT NULL,
  PRIMARY KEY(CONSENT_ID, CONSENT_TYPE, METADATA_KEY),
  CONSTRAINT FK_CONSENT_ID_UK_INITIATION FOREIGN KEY (CONSENT_ID) REFERENCES UK_TRANSACTION_INITIATION (ID)
  ON DELETE CASCADE
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[UK_NOTIFICATION]') AND TYPE IN (N'U'))
CREATE TABLE UK_NOTIFICATION (
  ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  RESOURCE_ID varchar(50) NOT NULL,
  RESOURCE_TYPE varchar(50) NOT NULL,
  RESOURCE_LINK varchar(200) NOT NULL,
  VERSION varchar(10) NOT NULL,
  CLIENT_ID varchar(50) NOT NULL,
  STATUS varchar(10) NOT NULL,
  TIMESTAMP DATETIME NOT NULL,
  LAST_RETRY_TIME DATETIME NOT NULL,
  NEXT_RETRY_TIME DATETIME  NOT NULL
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[OB_DCR_DETAILS]') AND TYPE IN (N'U'))
CREATE TABLE OB_DCR_DETAILS (
  ID VARCHAR(255)  NOT NULL,
  TPP_NAME VARCHAR(255) NOT NULL,
  REQUEST_HEADER NVARCHAR(MAX) NOT NULL CHECK ( ISJSON(REQUEST_HEADER ) > 0 ),
  REQUEST   NVARCHAR(MAX) NOT NULL CHECK ( ISJSON(REQUEST) > 0 ),
  CLIENT_ID VARCHAR(255) NOT NULL,
  SOFTWARE_ENV VARCHAR(255) NOT NULL,
  SPEC_VERSION VARCHAR(64) NOT NULL,
  CREATED_TIMESTAMP DATETIME NOT NULL DEFAULT getdate(),
  STATUS VARCHAR(64) NOT NULL,
  STATUS_UPDATED_TIMESTAMP DATETIME NOT NULL DEFAULT getdate(),
  PRIMARY KEY (ID),
);

IF NOT EXISTS ( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[UK_NOTIFICATION]') AND TYPE IN (N'U'))
CREATE TABLE UK_NOTIFICATION (
  ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
  RESOURCE_ID varchar(50) NOT NULL,
  RESOURCE_TYPE varchar(50) NOT NULL,
  RESOURCE_LINK varchar(200) NOT NULL,
  VERSION varchar(10) NOT NULL,
  CLIENT_ID varchar(50) NOT NULL,
  STATUS varchar(10) NOT NULL,
  TIMESTAMP DATETIME NOT NULL,
  LAST_RETRY_TIME DATETIME NOT NULL,
  NEXT_RETRY_TIME DATETIME  NOT NULL
);

IF COL_LENGTH('[DBO].[UK_TRANSACTION_INITIATION]', 'STATUS_UPDATED_TIMESTAMP') IS NULL
BEGIN
    ALTER TABLE UK_TRANSACTION_INITIATION ADD STATUS_UPDATED_TIMESTAMP DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
    ALTER TABLE UK_TRANSACTION_INITIATION ADD SPEC_VERSION VARCHAR(64) NOT NULL DEFAULT 'UK200';
END;

IF COL_LENGTH('[DBO].[UK_ACCOUNT_INITIATION]', 'SPEC_VERSION') IS NULL
BEGIN
    ALTER TABLE UK_ACCOUNT_INITIATION ADD SPEC_VERSION VARCHAR(64) NOT NULL DEFAULT 'UK200';
END;


IF (NOT EXISTS( SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N'[DBO].[UK_NOTIFICATION_CALLBACK]') AND TYPE IN (N'U')))
    CREATE TABLE UK_NOTIFICATION_CALLBACK (
    ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    CLIENT_ID varchar(50) NOT NULL,
    REQUEST varchar(1000) NOT NULL CHECK ( ISJSON(REQUEST) > 0 ),
    SPEC_VERSION varchar(10) NOT NULL,
    TIMESTAMP DATETIME NOT NULL DEFAULT getdate()
    );
ELSE
  IF COL_LENGTH('[DBO].[UK_NOTIFICATION_CALLBACK]', 'SPEC_VERSION') IS NULL
  BEGIN
    ALTER TABLE UK_NOTIFICATION_CALLBACK ADD SPEC_VERSION VARCHAR(64) NOT NULL DEFAULT 'UK300';
    ALTER TABLE UK_NOTIFICATION_CALLBACK ADD REQUEST varchar(1000) NOT NULL DEFAULT '{}' CHECK ( ISJSON(REQUEST) > 0 );
    UPDATE UK_NOTIFICATION_CALLBACK SET REQUEST = (SELECT ID, URL, VERSION FROM UK_NOTIFICATION_CALLBACK b WHERE b.ID = UK_NOTIFICATION_CALLBACK.ID FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER);
  END;

IF COL_LENGTH('[DBO].[UK_COF_INITIATION]', 'SPEC_VERSION') IS NULL
BEGIN
    ALTER TABLE UK_COF_INITIATION ADD SPEC_VERSION VARCHAR(64) NOT NULL DEFAULT 'UK300';
END;

