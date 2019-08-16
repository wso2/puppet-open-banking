
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

  $packages = ["unzip"]

  # Maximum and minimum memory sizes for JVM
  $jvmxms = '2048m'
  $jvmxmx = '2048m'

  # User details
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # JDK Distributions
  $java_dir = '/opt'
  $jdk_name = 'jdk1.8.0_161'
  $java_symlink = "${java_dir}/java"
  $java_home = "${java_dir}/${jdk_name}"

  $wso2_service_name = "wso2${profile}"
  $version = '1.4.0'
  $pack = "wso2-obam-${version}"

  # Pack Directories
  $target = '/mnt'
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"
  $carbon_home = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"

  # from apim

  $start_script_template = 'bin/wso2server.sh'

  # carbon.service params

  $server_script_path ="${product_dir}/${pack}/bin/wso2server.sh"
  $pid_file_path="${product_dir}/${pack}/wso2carbon.pid"

  # Hostname changes in apimanager.xml,openbanking.xml,carbon.xml and velocity_template.xml params
  $iam_hostname = 'localhost'
  $analytics_hostname= 'localhost'
  $apim_hostname= 'localhost'
  $bps_hostname = 'localhost'

  # DBMS related variables

  # master-datasources.xml and open-banking-datasources.xml params
  $dbms = 'mysql'
  $db_host = 'localhost'
  $db_user = 'root'
  $db_pass = 'root'
  $db_driver = 'com.mysql.jdbc.Driver'

  # master-datasources.xml params - database names
  $db_apimgt = 'openbank_apimgtdb'
  $db_apimgt_stat = 'openbank_apimgt_statsdb'
  $db_mb_store = 'openbank_mbstoredb'
  $db_am_config = 'openbank_am_configdb'
  $db_gov = 'openbank_govdb'
  $db_user_store = 'openbank_userdb'

  # open-banking-datasources.xml params
  $db_open_banking_store = 'openbank_openbankingdb'

  # jaggeryapps/admin/site/conf/site.json params
  $work_flow_server_url = "${bps_hostname}:9445/services/"

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
  # 'repository/conf/axis2/axis2.xml', not used yet
    'repository/deployment/server/executionplans/global_FreqPerDay.siddhiql',
    'repository/deployment/server/jaggeryapps/admin/site/conf/site.json',
    'repository/deployment/server/jaggeryapps/store/site/conf/site.json',
  ]

  # master-datasources.xml params
    $db_apimgt_url = "jdbc:mysql://${db_host}:3306/${db_apimgt}?autoReconnect=true&amp;useSSL=false"
    $db_apimgt_username = 'root'
    $db_apimgt_password =  'root'
    $db_apimgt_validation_query = 'SELECT 1'
    $db_apimgt_driver = 'com.mysql.jdbc.Driver'

    $db_apimgt_stat_url= "jdbc:mysql://${db_host}:3306/${db_apimgt_stat}?autoReconnect=true&amp;useSSL=false"
    $db_apimgt_stat_username = 'root'
    $db_apimgt_stat_password = 'root'
    $db_apimgt_stat_validation_query ='SELECT 1'
    $db_apimgt_stat_driver = 'com.mysql.jdbc.Driver'

    $db_mb_store_url = "jdbc:mysql://${db_host}:3306/${db_mb_store}?autoReconnect=true&amp;useSSL=false"
    $db_mb_store_username ='root'
    $db_mb_store_password = 'root'
    $db_mb_store_validation_query ='SELECT 1'
    $db_mb_store_driver = 'com.mysql.jdbc.Driver'

    $db_am_config_url ="jdbc:mysql://${db_host}:3306/${db_am_config}?autoReconnect=true&amp;useSSL=false"
    $db_am_config_username ='root'
    $db_am_config_password = 'root'
    $db_am_config_validation_query ='SELECT 1'
    $db_am_config_driver = 'com.mysql.jdbc.Driver'

    $db_gov_url = "jdbc:mysql://${db_host}:3306/${db_gov}?autoReconnect=true&amp;useSSL=false"
    $db_gov_username ='root'
    $db_gov_password = 'root'
    $db_gov_validation_query ='SELECT 1'
    $db_gov_driver = 'com.mysql.jdbc.Driver'

    $db_user_store_url = "jdbc:mysql://${db_host}:3306/${db_user_store}?autoReconnect=true&amp;useSSL=false"
    $db_user_store_username ='root'
    $db_user_store_password = 'root'
    $db_user_store_validation_query ='SELECT 1'
    $db_user_store_driver = 'com.mysql.jdbc.Driver'

  # open-banking-datasources.xml params
    $db_open_banking_store_url = "jdbc:mysql://${db_host}:3306/${db_open_banking_store}?autoReconnect=true&amp;useSSL=false"
    $db_open_banking_store_username ='root'
    $db_open_banking_store_password = 'root'
    $db_open_banking_store_validation_query ='SELECT 1'
    $db_open_banking_store_driver = 'com.mysql.jdbc.Driver'

  # If dbms =mysql use following URLs
  # 
  # #master-datasources.xml params
  # $db_apimgt_url = "jdbc:mysql://${db_host}:3306/${db_apimgt}?autoReconnect=true&amp;useSSL=false"
  # $db_apimgt_stat_url= "jdbc:mysql://${db_host}:3306/${db_apimgt_stat}?autoReconnect=true&amp;useSSL=false"
  # $db_mb_store_url = "jdbc:mysql://${db_host}:3306/${db_mb_store}?autoReconnect=true&amp;useSSL=false"
  # $db_am_config_url ="jdbc:mysql://${db_host}:3306/${db_am_config}?autoReconnect=true&amp;useSSL=false"
  # $db_gov_url = "jdbc:mysql://${db_host}:3306/${db_gov}?autoReconnect=true&amp;useSSL=false"
  # $db_user_store_url = "jdbc:mysql://${db_host}:3306/${db_user_store}?autoReconnect=true&amp;useSSL=false"
  # 
  # #open-banking-datasources.xml params
  # $db_open_banking_store_url = "jdbc:mysql://${db_host}:3306/${db_open_banking_store}?autoReconnect=true&amp;useSSL=false"











}
