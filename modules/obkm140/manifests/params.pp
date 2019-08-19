
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

class obkm140::params {

  $packages = ['unzip']

  # User Details
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # JDK Distributions
  $java_dir = '/opt'
  $java_symlink = "${java_dir}/java"
  $jdk_name = 'jdk1.8.0_161'
  $java_home = "${java_dir}/${jdk_name}"

  # Pack Directories
  $target = '/mnt'
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"
  $version = '1.4.0'
  $pack = "wso2-obkm-${version}"
  $product_binary = "${pack}.zip"
  $carbon_home = "${product_dir}/${pack}"

  $wso2_service_name = "wso2${profile}"
  $start_script_template = 'bin/wso2server.sh'
  $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
  $pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"

  # Configure databases related properties
  $db_type = 'mysql'
  $db_host = 'localhost'
  $db_user = 'root'
  $db_pass = 'root'
  $db_driver = 'com.mysql.jdbc.Driver'

  $db_apimgt = 'openbank_apimgtdb'
  $db_is_config = 'openbank_iskm_configdb'
  $db_gov = 'openbank_govdb'
  $db_user_store = 'openbank_userdb'
  $db_open_banking_store = 'openbank_openbankingdb'

  # hostname configurations
  $iam_hostname = 'localhost'
  $apim_hostname = 'localhost'
  $analytics_hostname = 'localhost'

  # jaggeryapps/admin/site/conf/site.json and openbanking.xml params
  $spec = 'UK'

  # H2
  # ----- datasources config params -----
  # ----- Master-datasources config params -----
  $db_apimgt_url = 'jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_apimgt_username = 'wso2carbon'
  $db_apimgt_password =  'wso2carbon'
  $db_apimgt_validation_query = 'SELECT 1'
  $db_apimgt_driver = 'org.h2.Driver'

  $db_gov_url = 'jdbc:h2:repository/database/WSO2REG_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_gov_username ='wso2carbon'
  $db_gov_password = 'wso2carbon'
  $db_gov_validation_query ='SELECT 1'
  $db_gov_driver = 'org.h2.Driver'

  $db_km_config_url = 'jdbc:h2:repository/database/WSO2Config_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_km_config_username ='wso2carbon'
  $db_km_config_password = 'wso2carbon'
  $db_km_config_validation_query ='SELECT 1'
  $db_km_config_driver = 'org.h2.Driver'

  $db_user_store_url = 'jdbc:h2:repository/database/WSO2UM_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_user_store_username ='wso2carbon'
  $db_user_store_password = 'wso2carbon'
  $db_user_store_validation_query ='SELECT 1'
  $db_user_store_driver = 'org.h2.Driver'

  # ----- Open Banking datasources config params -----
  $db_open_banking_store_url = 'jdbc:h2:repository/database/WSO2_OPEN_BANKING_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_open_banking_store_username ='wso2carbon'
  $db_open_banking_store_password = 'wso2carbon'
  $db_open_banking_store_validation_query ='SELECT 1'
  $db_open_banking_store_driver = 'org.h2.Driver'

  $template_list = [
    # configure_datasources
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/open-banking-datasources.xml',

    # copy xml files
    'repository/conf/carbon.xml',
    'repository/conf/axis2/axis2.xml',
    'repository/conf/registry.xml',
    'repository/conf/user-mgt.xml',
    'repository/conf/tomcat/catalina-server.xml',

    # change_hostname
    'repository/conf/identity/identity.xml',
    'repository/conf/identity/application-authentication.xml',
    'repository/conf/finance/open-banking.xml',
    'repository/deployment/server/jaggeryapps/consentmgt/configs/conf.json',

    # configure speccarbon_homecarbon_home
    'repository/deployment/server/jaggeryapps/ccportal/configs/conf.json'
  ]
}
