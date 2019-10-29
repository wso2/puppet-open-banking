CREATE TABLE OB_DCR_DETAILS (
  ID        VARCHAR(255)  NOT NULL,
  TPP_NAME VARCHAR(255) NOT NULL,
  REQUEST_HEADER NVARCHAR(MAX) NOT NULL CHECK ( ISJSON(REQUEST_HEADER ) > 0 ),
  REQUEST   NVARCHAR(MAX) NOT NULL CHECK ( ISJSON(REQUEST) > 0 ),
  CLIENT_ID VARCHAR(255) NOT NULL,
  SOFTWARE_ENV VARCHAR(255) NOT NULL,
  APPLICATION_ID INT NOT NULL,
  SOFTWARE_ID VARCHAR(255) NOT NULL,
  SPEC_VERSION VARCHAR(64) NOT NULL,
  CREATED_TIMESTAMP DATETIME      NOT NULL DEFAULT getdate(),
  STATUS VARCHAR(64) NOT NULL,
  CLID_ISSUED_AT INT NOT NULL,
  STATUS_UPDATED_TIMESTAMP DATETIME      NOT NULL DEFAULT getdate(),
  PRIMARY KEY (ID),
);