-- Migrate from 1.0.0 to 1.1.0-M2
ALTER TABLE UK_ACCOUNT_INITIATION ADD REVOCATION_USER VARCHAR(255) DEFAULT NULL;
ALTER TABLE UK_ACCOUNT_INITIATION ADD REVOCATION_REASON NVARCHAR(MAX) DEFAULT NULL;

-- Migrate from 1.1.0-M2 to 1.1.0-M3
sp_rename 'UK_ACCOUNT_INITIATION.TIMESTAMP', 'CREATED_TIMESTAMP', 'COLUMN';
ALTER TABLE UK_ACCOUNT_INITIATION ADD STATUS_UPDATED_TIMESTAMP DATETIME NOT NULL DEFAULT getdate();

ALTER TABLE UK_ACCOUNT_INITIATION DROP COLUMN REVOCATION_REASON;
ALTER TABLE UK_ACCOUNT_INITIATION DROP COLUMN REVOCATION_USER;

CREATE TABLE UK_ACCOUNT_CONSENT_REVOCATION_HISTORY (
  CONSENT_ID VARCHAR(255) NOT NULL,
  REVOCATION_USER VARCHAR(255) NOT NULL,
  REVOCATION_REASON VARCHAR(60000) NOT NULL,
  PRIMARY KEY (CONSENT_ID),
  CONSTRAINT FK_CONSENT_ID_UK_ACCOUNT_CONSENT_REVOCATION_HISTORY FOREIGN KEY (CONSENT_ID) REFERENCES UK_ACCOUNT_INITIATION (ID)
    ON DELETE CASCADE
);
