ALTER TABLE BG_PAYMENT_CONSENT
ADD COLUMN API_VERSION VARCHAR(45) NOT NULL AFTER PSU_CORPORATE_ID_TYPE DEFAULT 'v1.1.0';

ALTER TABLE BG_ACCOUNT_INITIALIZATION
ADD COLUMN API_VERSION VARCHAR(45) NOT NULL AFTER TPP_UNIQUE_ID DEFAULT 'v1.1.0';