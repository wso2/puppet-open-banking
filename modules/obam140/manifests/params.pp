
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

class obam140::params {

  $packages = ['unzip']

  # Maximum and minimum memory sizes for JVM
  $jvmxms = '2048m'
  $jvmxmx = '2048m'

  # User details
  $user           = 'wso2carbon'
  $user_group     = 'wso2'
  $user_id        = 802
  $user_group_id  = 802

  # JDK distributions
  $java_dir         = '/opt'
  $jdk_name         = 'jdk1.8.0_161'
  $java_symlink     = "${java_dir}/java"
  $java_home        = "${java_dir}/${jdk_name}"

  $wso2_service_name  = "wso2${profile}"
  $version            = '1.4.0'
  $pack               = "wso2-obam-${version}"

  # Pack directories
  $target         = '/mnt'
  $product_dir    = "${target}/${profile}"
  $pack_dir       = "${target}/${profile}/packs"
  $carbon_home    = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  $start_script_template = 'bin/wso2server.sh'

  # carbon.service params
  $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
  $pid_file_path      = "${product_dir}/${pack}/wso2carbon.pid"

  # Hostname changes in apimanager.xml, openbanking.xml, carbon.xml and velocity_template.xml params
  $iam_hostname       = 'localhost'
  $analytics_hostname = 'localhost'
  $apim_hostname      = 'localhost'
  $bps_hostname       = 'localhost'

  # jaggeryapps/admin/site/conf/site.json params
  $work_flow_server_url = "https://${bps_hostname}:9445/services/"

  # jaggeryapps/admin/site/conf/site.json,openbaking.xml params
  $spec = 'UK' #UK,Berlin or STET 

  # template list
  $template_list = [
    'repository/conf/api-manager.xml',
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/open-banking-datasources.xml',
    'repository/conf/carbon.xml',
    'repository/resources/api_templates/velocity_template.xml',
    'repository/conf/finance/open-banking.xml',
    'repository/deployment/server/executionplans/global_FreqPerDay.siddhiql',
    'repository/deployment/server/jaggeryapps/admin/site/conf/site.json',
    'repository/deployment/server/jaggeryapps/store/site/conf/site.json',
  ]

  # DBMS related variables

  # master-datasources.xml params
    $db_apimgt_url              = 'jdbc:h2:repository/database/WSO2CARBON_DB;DB_CLOSE_ON_EXIT=FALSE'
    $db_apimgt_username         = 'wso2carbon'
    $db_apimgt_password         = 'wso2carbon'
    $db_apimgt_validation_query = 'SELECT 1'
    $db_apimgt_driver           = 'org.h2.Driver'

    $db_mb_store_url              = 'jdbc:h2:repository/database/WSO2MB_DB;DB_CLOSE_ON_EXIT=FALSE;LOCK_TIMEOUT=60000'
    $db_mb_store_username         = 'wso2carbon'
    $db_mb_store_password         = 'wso2carbon'
    $db_mb_store_validation_query = 'SELECT 1'
    $db_mb_store_driver           = 'org.h2.Driver'

    $db_apimgt_stat_url               = 'jdbc:h2:repository/database/WSO2_APIMGT_STAT_DB;DB_CLOSE_ON_EXIT=FALSE;'
    $db_apimgt_stat_username          = 'wso2carbon'
    $db_apimgt_stat_password          = 'wso2carbon'
    $db_apimgt_stat_validation_query  = 'SELECT 1'
    $db_apimgt_stat_driver            = 'org.h2.Driver'

    $db_am_config_url                 = 'jdbc:h2:repository/database/WSO2_AM_CONFIG_DB;DB_CLOSE_ON_EXIT=FALSE;'
    $db_am_config_username            = 'wso2carbon'
    $db_am_config_password            = 'wso2carbon'
    $db_am_config_validation_query    = 'SELECT 1'
    $db_am_config_driver              = 'org.h2.Driver'

    $db_gov_url                       = 'jdbc:h2:repository/database/WSO2_GOV_DB;DB_CLOSE_ON_EXIT=FALSE;'
    $db_gov_username                  = 'wso2carbon'
    $db_gov_password                  = 'wso2carbon'
    $db_gov_validation_query          = 'SELECT 1'
    $db_gov_driver                    = 'org.h2.Driver'

    $db_user_store_url                = 'jdbc:h2:repository/database/WSO2_USER_STORE_DB;DB_CLOSE_ON_EXIT=FALSE;'
    $db_user_store_username           = 'wso2carbon'
    $db_user_store_password           = 'wso2carbon'
    $db_user_store_validation_query   = 'SELECT 1'
    $db_user_store_driver             = 'org.h2.Driver'

  # open-banking-datasources.xml params
    $db_open_banking_store_url              = 'jdbc:h2:repository/database/WSO2_OPEN_BANKING_STORE_DB;DB_CLOSE_ON_EXIT=FALSE;'
    $db_open_banking_store_username         = 'wso2carbon'
    $db_open_banking_store_password         = 'wso2carbon'
    $db_open_banking_store_validation_query = 'SELECT 1'
    $db_open_banking_store_driver           = 'org.h2.Driver'

}
