#----------------------------------------------------------------------------
#  Copyright (c) 2019 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#----------------------------------------------------------------------------

class obkm::params {

  $user = 'wso2carbon'
  $user_id = 802
  $user_group = 'wso2'
  $user_home = '/home/$user'
  $user_group_id = 802
  $service_name = 'wso2is'
  $obkm_hostname = 'CF_OBKM_HOSTNAME'
  $obsp_hostname = 'localhost'
  $obam_hostname = 'CF_OBAM_HOSTNAME'
  $obkm_mgt_hostname = 'localhost'
  $deployed_specification = 'CF_DEPLOYED_SPEC'
  $enable_test_mode = 'false'
  $jdk_version = 'JDK_TYPE'
  $db_managment_system = 'CF_DBMS'
  $oracle_sid = 'WSO2ISDB'
  $db_password = 'CF_DB_PASSWORD'
  $aws_access_key = 'access-key'
  $aws_secret_key = 'secretkey'
  $aws_region = 'REGION_NAME'
  $local_member_host = $::ipaddress
  $http_proxy_port  = '80'
  $https_proxy_port = '443'
  $is_package = 'wso2-obkm-1.3.0.zip'

  # Define the templates
  $start_script_template = 'bin/wso2server.sh'

  $template_list = [
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/open-banking-datasources.xml',
    'repository/conf/finance/open-banking.xml',
    'repository/deployment/server/jaggeryapps/consentmgt/configs/conf.json',
    'repository/deployment/server/jaggeryapps/ccportal/configs/conf.json',
    'repository/conf/identity/application-authentication.xml',
    'repository/conf/identity/identity.xml',
    'repository/conf/carbon.xml',
    'repository/conf/user-mgt.xml',
    'repository/conf/axis2/axis2.xml',
    'repository/conf/tomcat/catalina-server.xml',
  ]

  $clustering = {
    enabled => true,
  }

  # Configuration Params
  if $jdk_version == 'ORACLE_JDK8' {
    $jdk_type = "jdk-8u144-linux-x64.tar.gz"
    $jdk_path = "jdk1.8.0_144"
  } elsif $jdk_version == 'OPEN_JDK8' {
    $jdk_type = "jdk-8u192-ea-bin-b02-linux-x64-19_jul_2018.tar.gz"
    $jdk_path = "jdk1.8.0_192"
  } elsif $jdk_version == 'Corretto_JDK8' {
    $jdk_type = "amazon-corretto-8.202.08.2-linux-x64.tar.gz"
    $jdk_path = "amazon-corretto-8.202.08.2-linux-x64"
  }

  # ----- Master-datasources config params -----

  if $db_managment_system == 'mysql' {
    $wso2_reg_db_name = 'CF_DB_USERNAME'
    $wso2_am_db_name = 'CF_DB_USERNAME'
    $wso2_config_db_name = 'CF_DB_USERNAME'
    $wso2_um_db_name = 'CF_DB_USERNAME'
    $wso2_consent_db_name = 'CF_DB_USERNAME'
    $wso2_reg_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_govdb?autoReconnect=true&amp;useSSL=false'
    $wso2_am_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_apimgtdb?autoReconnect=true&amp;useSSL=false'
    $wso2_config_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_iskm_configdb?autoReconnect=true&amp;useSSL=false'
    $wso2_um_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_userdb?autoReconnect=true&amp;useSSL=false'
    $wso2_consent_db_url = 'jdbc:mysql://CF_RDS_URL:3306/openbank_consent_db?autoReconnect=true&amp;useSSL=false'
    $db_driver_class_name = 'com.mysql.jdbc.Driver'
    $db_connector = 'mysql-connector-java-5.1.41-bin.jar'
    $db_validation_query = 'SELECT 1'
  } elsif $db_managment_system =~ 'oracle' {
    $wso2_reg_db_name = 'openbank_govdb'
    $wso2_am_db_name = 'openbank_apimgtdb'
    $wso2_config_db_name = 'openbank_iskm_configdb'
    $wso2_um_db_name = 'openbank_userdb'
    $wso2_consent_db_name = 'openbank_consent_db'
    $wso2_reg_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_am_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_config_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wso2_um_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $wos2_consent_db_url = "jdbc:oracle:thin:@CF_RDS_URL:1521/${oracle_sid}"
    $db_driver_class_name = 'oracle.jdbc.OracleDriver'
    $db_validation_query = 'SELECT 1 FROM DUAL'
    $db_connector = 'ojdbc8.jar'
  } elsif $db_managment_system == 'sqlserver-se' {
    $wso2_reg_db_name = 'CF_DB_USERNAME'
    $wso2_am_db_name = 'CF_DB_USERNAME'
    $wso2_config_db_name = 'CF_DB_USERNAME'
    $wso2_um_db_name = 'CF_DB_USERNAME'
    $wso2_consent_db_name = 'CF_DB_USERNAME'
    $wso2_reg_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_govdb;SendStringParametersAsUnicode=false'
    $wso2_am_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_apimgtdb;SendStringParametersAsUnicode=false'
    $wso2_config_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_iskm_configdb;SendStringParametersAsUnicode=false'
    $wso2_um_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_userdb;SendStringParametersAsUnicode=false'
    $wso2_consent_db_url = 'jdbc:sqlserver://CF_RDS_URL:1433;databaseName=openbank_consent_db;SendStringParametersAsUnicode=false'
    $db_driver_class_name = 'com.microsoft.sqlserver.jdbc.SQLServerDriver'
    $db_connector = 'mssql-jdbc-7.0.0.jre8.jar'
    $db_validation_query = 'SELECT 1'
  } elsif $db_managment_system == 'postgres' {
    $wso2_reg_db_name = 'CF_DB_USERNAME'
    $wso2_am_db_name = 'CF_DB_USERNAME'
    $wso2_config_db_name = 'CF_DB_USERNAME'
    $wso2_um_db_name = 'CF_DB_USERNAME'
    $wso2_consent_db_name = 'CF_DB_USERNAME'
    $wso2_reg_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/openbank_govdb'
    $wso2_am_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/openbank_apimgtdb'
    $wso2_config_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/openbank_iskm_configdb'
    $wso2_um_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/openbank_userdb'
    $wso2_consent_db_url = 'jdbc:postgresql://CF_RDS_URL:5432/openbank_consent_db'
    $db_driver_class_name = 'org.postgresql.Driver'
    $db_connector = 'postgresql-42.2.5.jar'
    $db_validation_query = 'SELECT 1; COMMIT'
  }

  $wso2_reg_db = {
    url               => $wso2_reg_db_url,
    username          => $wso2_reg_db_name,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }

  $wso2_am_db = {
    url               => $wso2_am_db_url,
    username          => $wso2_am_db_name,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }

  $wso2_config_db = {
    url               => $wso2_config_db_url,
    username          => $wso2_config_db_name,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }

  $wso2_um_db = {
    url               => $wso2_um_db_url,
    username          => $wso2_um_db_name,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }

  $wso2_consent_db = {
    url               => $wso2_consent_db_url,
    username          => $wso2_consent_db_name,
    password          => $db_password,
    driver_class_name => $db_driver_class_name,
    validation_query  => $db_validation_query,
  }

  # Carbon.xml
  $ports_offset = 3

  # user-mgt.xml
  $enable_scim = true

  $key_store = {
    type         => 'JKS',
    password     => 'wso2carbon',
    key_alias    => 'wso2carbon',
    location     => '${carbon.home}/repository/resources/security/wso2carbon.jks',
    key_password => 'wso2carbon',
  }

  $trust_store = {
    location => '${carbon.home}/repository/resources/security/client-truststore.jks',
    type     => 'JKS',
    password => 'wso2carbon'
  }
}
