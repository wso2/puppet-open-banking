/
BEGIN
  FOR item IN (
    SELECT *
       FROM all_constraints
       WHERE table_name = 'UK_CONSENT_REV'
  )
  LOOP
   EXECUTE immediate 'ALTER TABLE UK_CONSENT_REV DROP CONSTRAINT ' || item.CONSTRAINT_NAME;
  END LOOP;
  EXECUTE IMMEDIATE 'CREATE SEQUENCE UK_CONSENT_REV_SEQUENCE START WITH 1 INCREMENT BY 1 nomaxvalue';
  EXECUTE IMMEDIATE 'ALTER TABLE UK_CONSENT_REV ADD (ID NUMBER DEFAULT UK_CONSENT_REV_SEQUENCE.nextval)';
  EXECUTE IMMEDIATE 'ALTER TABLE UK_CONSENT_REV ADD CONSTRAINT UK_CONSENT_REV_PK PRIMARY KEY (ID)';
END;
/
--update the conditional auth scripts for existing service providers
--run the below script against the openbanking_apimgtdb
--please make sure that the common.auth.script file is accessible a location at the db server
CREATE DIRECTORY AUTHS AS '<path where the conditional auth script is stored>';
GRANT READ ON DIRECTORY AUTHS TO public;
GRANT WRITE ON DIRECTORY AUTHS TO public;
declare
l_bfile bfile;
l_buffer raw(32767);
amt BINARY_INTEGER := 32767;
begin
l_bfile := bfilename('AUTHS','common.auth.script.js' );
dbms_lob.fileopen( l_bfile );
dbms_lob.read( l_bfile, amt, 1, l_buffer );
UPDATE SP_AUTH_SCRIPT SET CONTENT = l_buffer WHERE APP_ID IN
(SELECT ID FROM SP_APP WHERE APP_NAME LIKE '%PRODUCTION%' OR APP_NAME LIKE '%SANDBOX%' AND ) AND CONTENT IS NOT NULL;
dbms_lob.fileclose(l_bfile );
end;
/
