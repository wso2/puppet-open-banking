ALTER TABLE OB_DCR_DETAILS
ADD COLUMN APPLICATION_ID INT NOT NULL,
ADD COLUMN SOFTWARE_ID VARCHAR(255) NOT NULL,
ADD COLUMN CLID_ISSUED_AT INT NOT NULL;