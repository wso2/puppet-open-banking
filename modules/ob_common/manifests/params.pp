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

class ob_common::params {

  $packages = ['unzip']

  # User details
  $user           = 'wso2carbon'
  $user_group     = 'wso2'
  $user_id        = 802
  $user_group_id  = 802

  # JDK distributions
  $java_dir     = '/opt'
  $java_symlink = "${java_dir}/java"
  $jdk_name     = 'jdk1.8.0_161'
  $java_home    = "${java_dir}/${jdk_name}"

  $version            = '2.0.0-ALPHA'

  $target         = '/mnt'
  $product_dir    = "${target}/${profile}"
  $pack_dir       = "${target}/${profile}/packs"
  $wso2_service_name  = "wso2${profile}"

  # Profile configurations
  case $profile {
    'obiam': {
      $pack               = "wso2-obiam-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path      = "${product_dir}/${pack}/wso2carbon.pid"
    }
    'obam': {
      $pack               = "wso2-obam-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
      $pid_file_path      = "${product_dir}/${pack}/wso2carbon.pid"
    }
    'obbi_dashboard': {
      $pack               = "wso2-obbi-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/dashboard.sh"
      $pid_file_path      = "${product_dir}/${pack}/wso2/dashboard/runtime.pid"
    }
    'obbi_worker': {
      $pack               = "wso2-obbi-${version}"
      $server_script_path = "${product_dir}/${pack}/bin/worker.sh"
      $pid_file_path      = "${product_dir}/${pack}/wso2/worker/runtime.pid"
    }
  }

  # Pack Directories
  $carbon_home    = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # Hostname changes in deployment.toml, conf.json params and velocity_template.xml params
  $iam_hostname       = 'localhost'
  $analytics_hostname = 'localhost'
  $apim_hostname      = 'localhost'
  $bps_hostname       = 'localhost'

  # jaggeryapps/admin/site/conf/site.json,deployment.toml params
  $spec = 'UK' #UK,Berlin or AU

  # DBMS related variables

  # master-datasources.xml params for databases
  $db_apimgt_url                     = 'jdbc:h2:repository/database/WSO2AM_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_apimgt_username                = 'wso2carbon'
  $db_apimgt_password                = 'wso2carbon'
  $db_apimgt_validation_query        = 'SELECT 1'
  $db_apimgt_driver                  = 'org.h2.Driver'

  $db_apimgt_stat_url                = 'jdbc:h2:repository/database/WSO2_APIMGT_STAT_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_apimgt_stat_username           = 'wso2carbon'
  $db_apimgt_stat_password           = 'wso2carbon'
  $db_apimgt_stat_validation_query   = 'SELECT 1'
  $db_apimgt_stat_driver             = 'org.h2.Driver'

  $db_am_config_url                 = 'jdbc:h2:repository/database/WSO2_AM_CONFIG_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_am_config_username            = 'wso2carbon'
  $db_am_config_password            = 'wso2carbon'
  $db_am_config_validation_query    = 'SELECT 1'
  $db_am_config_driver              = 'org.h2.Driver'

  $db_iam_config_url                = 'jdbc:h2:repository/database/WSO2Config_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_iam_config_username           = 'wso2carbon'
  $db_iam_config_password           = 'wso2carbon'
  $db_iam_config_validation_query   = 'SELECT 1'
  $db_iam_config_driver             = 'org.h2.Driver'

  $db_gov_url                       = 'jdbc:h2:repository/database/WSO2REG_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_gov_username                  = 'wso2carbon'
  $db_gov_password                  = 'wso2carbon'
  $db_gov_validation_query          = 'SELECT 1'
  $db_gov_driver                    = 'org.h2.Driver'

  $db_user_store_url                = 'jdbc:h2:repository/database/WSO2UM_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_user_store_username           = 'wso2carbon'
  $db_user_store_password           = 'wso2carbon'
  $db_user_store_validation_query   = 'SELECT 1'
  $db_user_store_driver             = 'org.h2.Driver'

  # open-banking-datasources.xml params
  $db_open_banking_store_url                = 'jdbc:h2:repository/database/WSO2_OPEN_BANKING_STORE_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_open_banking_store_username           = 'wso2carbon'
  $db_open_banking_store_password           = 'wso2carbon'
  $db_open_banking_store_validation_query   = 'SELECT 1'
  $db_open_banking_store_driver             = 'org.h2.Driver'

  # worker/deployment.yaml and dashboard/deployment.yaml params for databases

  $db_geo_location_url                     = 'jdbc:h2:repository/database/WSO2_OPEN_BANKING_GEOLOCATION_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_geo_location_username                = 'wso2carbon'
  $db_geo_location_password                = 'wso2carbon'
  $db_geo_location_validation_query        = 'SELECT 1'
  $db_geo_location_driver                  = 'org.h2.Driver'

  $db_ob_reporting_url                     = 'jdbc:h2:repository/database/WSO2_OPEN_BANKING_REPORTING_STATS_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_ob_reporting_username                = 'wso2carbon'
  $db_ob_reporting_password                = 'wso2carbon'
  $db_ob_reporting_validation_query        = 'SELECT 1'
  $db_ob_reporting_driver                  = 'org.h2.Driver'

  $db_ob_reporting_summarized_url                 = 'jdbc:h2:repository/database/WSO2_OPEN_BANKING_REPORTING_SUMMARIZED_DB;DB_CLOSE_ON_EXIT=FALSE'
  $db_ob_reporting_summarized_username            = 'wso2carbon'
  $db_ob_reporting_summarized_password            = 'wso2carbon'
  $db_ob_reporting_summarized_validation_query    = 'SELECT 1'
  $db_ob_reporting_summarized_driver              = 'org.h2.Driver'
}

