ALTER TABLE UK_CONSENT_REV drop primary key;
ALTER TABLE UK_CONSENT_REV ADD `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY;
--update the conditional auth scripts for existing service providers
--run the below script against the openbanking_apimgtdb
--please make sure that the common.auth.script file is accessible a location at the db server
UPDATE SP_AUTH_SCRIPT SET CONTENT = LOAD_FILE(<path to conditional auth script>);
WHERE APP_ID IN (SELECT ID FROM SP_APP WHERE APP_NAME LIKE '%PRODUCTION%' OR APP_NAME LIKE '%SANDBOX%') AND CONTENT IS NOT NULL;
