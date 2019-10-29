CREATE TABLE IF NOT EXISTS UK_NOTIFICATION_CALLBACK (
  ID int(11) NOT NULL AUTO_INCREMENT,
  CLIENT_ID varchar(50) NOT NULL,
  REQUEST varchar(1000) NOT NULL,
  TIMESTAMP timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  SPEC_VERSION varchar(10) NOT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS UK_NOTIFICATION (
 ID int(11) NOT NULL AUTO_INCREMENT,
 RESOURCE_ID varchar(50) NOT NULL,
 RESOURCE_TYPE varchar(50) NOT NULL,
 RESOURCE_LINK varchar(200) NOT NULL,
 VERSION varchar(10) NOT NULL,
 CLIENT_ID varchar(50) NOT NULL,
 STATUS varchar(10) NOT NULL,
 TIMESTAMP timestamp NULL DEFAULT NULL,
 LAST_RETRY_TIME timestamp NULL DEFAULT NULL,
 NEXT_RETRY_TIME timestamp NULL DEFAULT NULL,
 TRY_COUNT int(11) NOT NULL DEFAULT '0',
 PRIMARY KEY (ID)
 ) ENGINE=InnoDB;