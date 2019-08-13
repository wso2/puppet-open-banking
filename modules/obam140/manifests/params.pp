
class obam140::params {

  $jvmxms = '2048m'
  $jvmxmx = '2048m'

  $version = "1.4.0"

  # User details
  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  # JDK Distributions
  #need to support different JDKs

  $java_dir = "/opt"
  $jdk_name = "jdk1.8.0_161"
  $java_symlink = "${java_dir}/java"
  $java_home = "${java_dir}/${jdk_name}"

  $target = "/mnt"
  $product_dir = "${target}/${profile}" 
  $pack_dir = "${target}/${profile}/packs"

  $wso2_service_name = "wso2${profile}"
  
  $pack = "wso2-obam-${version}"

  # Pack Directories
  $carbon_home = "${product_dir}/${pack}"
  $product_binary = "${pack}.zip"


  #from apim

  $start_script_template = 'bin/wso2server.sh'

  # params for carbon.service.erb

  $server_script_path ="${product_dir}/${pack}/bin/wso2server.sh"
  $pid_file_path="${product_dir}/${pack}/wso2carbon.pid"

  /* database system related variables */
  
  #common params to master-datasources.xml and open-banking-datasources.xml
  $dbms = 'mysql'
  $db_host = 'localhost'
  $db_user = 'root'
  $db_pass = 'root'
  $db_driver = 'com.mysql.jdbc.Driver'

  #master-datasources.xml params

  $db_apimgt = 'openbank_apimgtdb'
  $db_apimgt_stat = 'openbank_apimgt_statsdb'
  $db_mb_store = 'openbank_mbstoredb'
  $db_am_config = 'openbank_am_configdb'
  $db_gov = 'openbank_govdb'
  $db_user_store = 'openbank_userdb'

  #open-banking-datasources.xml params
  $db_open_banking_store = 'openbank_openbankingdb'


  #apimanager.xml,openbanking.xml,carbon.xml params

  $iam_hostname = 'localhost'   #available in velocity_template.xml as well
  $analytics_hostname= 'localhost'
  $apim_hostname= 'localhost'


  #jaggeryapps/admin/site/conf/site.json params

  $bps_hostname = 'localhost'

  #jaggeryapps/admin/site/conf/site.json params
  $spec = 'UK' #UK or Berlin , common to openbanking.xml as well


  
  # Need to configure for databases other than mysql

  
  if ($dbms == 'mysql'){

    $db_apimgt_url = "jdbc:mysql://${db_host}:3306/${db_apimgt}?autoReconnect=true&amp;useSSL=false"
    $db_apimgt_stat_url= "jdbc:mysql://${db_host}:3306/${db_apimgt_stat}?autoReconnect=true&amp;useSSL=false"
    $db_mb_store_url = "jdbc:mysql://${db_host}:3306/${db_mb_store}?autoReconnect=true&amp;useSSL=false"
    $db_am_config_url ="jdbc:mysql://${db_host}:3306/${db_am_config}?autoReconnect=true&amp;useSSL=false"
    $db_gov_url = "jdbc:mysql://${db_host}:3306/${db_gov}?autoReconnect=true&amp;useSSL=false"
    $db_user_store_url = "jdbc:mysql://${db_host}:3306/${db_user_store}?autoReconnect=true&amp;useSSL=false"
    
  }

  #open-banking-datasources.xml params

  if ($dbms == 'mysql') {
    $db_open_banking_store_url = "jdbc:mysql://${db_host}:3306/${db_open_banking_store}?autoReconnect=true&amp;useSSL=false"
  }



  
  #template list

  $template_list = [
    'repository/conf/api-manager.xml',
    'repository/conf/datasources/master-datasources.xml',  
    'repository/conf/datasources/open-banking-datasources.xml',  
    'repository/conf/carbon.xml',     
    '/repository/resources/api_templates/velocity_template.xml',
    '/repository/conf/finance/open-banking.xml',
    'repository/conf/registry.xml',   #no changes in config - ob
    'repository/conf/user-mgt.xml',   #no changes in config - ob
    #'repository/conf/axis2/axis2.xml', not available in configure-am.sh
    'repository/deployment/server/executionplans/global_FreqPerDay.siddhiql',  #configuration changes removed in OBAM 1.4,therefore only a static file
    'repository/deployment/server/jaggeryapps/admin/site/conf/site.json',
    'repository/deployment/server/jaggeryapps/store/site/conf/site.json',
  ]


 # TODO :replace_mysql7_file_names_as_mysql() in config.sh 
  



}
