DECLARE @SQL VARCHAR(4000)
SET @SQL = 'ALTER TABLE UK_CONSENT_REV DROP CONSTRAINT |ConstraintName| '

SET @SQL = REPLACE(@SQL, '|ConstraintName|', ( SELECT   name
                                               FROM     sysobjects
                                               WHERE    xtype = 'PK'
                                                        AND parent_obj = OBJECT_ID('UK_CONSENT_REV')
                                             ));
EXEC (@SQL);
/
ALTER TABLE UK_CONSENT_REV ADD ID INTEGER IDENTITY(1,1);
ALTER TABLE UK_CONSENT_REV ADD CONSTRAINT PK_UK_CONSENT_REV PRIMARY KEY (ID);
/
ALTER TABLE UK_TRANSACTION_FILE
ALTER COLUMN PAYMENT_FILE VARCHAR(MAX);
/
--update the conditional auth scripts for existing service providers
--run the below script against the openbanking_apimgtdb
--please make sure that the common.auth.script file is accessible a location at the db server
DECLARE @script  VARBINARY(MAX)
SELECT @script=BulkColumn
FROM   OPENROWSET(BULK'/common.auth.script.js',SINGLE_BLOB) x
UPDATE SP_AUTH_SCRIPT SET CONTENT = @script
WHERE APP_ID IN (SELECT ID FROM SP_APP WHERE APP_NAME LIKE '%PRODUCTION%' OR APP_NAME LIKE '%SANDBOX%') AND CONTENT IS NOT NULL;
