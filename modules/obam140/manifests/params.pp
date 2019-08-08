
class obam140::params {

  $jvmxms = '2048m'
  $jvmxmx = '2048m'

  $version = "1.3.0"

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

  #params for carbon.service.erb

  $server_script_path ="${product_dir}/${pack}/bin/wso2server.sh"
  $pid_file_path="${product_dir}/${pack}/wso2carbon.pid"

  #database system related variables
  
  #common params to master-datasources.xml and open-banking-datasources.xml
  $dbms = '?'
  $DB_HOST = '?'
  $DB_USER = '?'
  $DB_PASS = '?'
  $DB_DRIVER = '?'

  #master-datasources.xml params
  $DB_APIMGT = '?'
  $DB_APIMGT_STAT = '?'
  $DB_MB_STORE = '?'
  $DB_AM_CONFIG = '?'
  $DB_GOV = '?'
  $DB_USER_STORE = '?'

  #open-banking-datasources.xml params
  $DB_OPEN_BANKING_STORE = '?'


  #apimanager.xml,openbanking.xml params

  $IAM_HOSTNAME == '?'   #available in velocity_template.xml as well
  $ANALYTICS_HOSTNAME= '?'
  $APIM_HOSTNAME= '?'


  #jaggeryapps/admin/site/conf/site.json params

  $BPS_HOSTNAME = '?'

  #jaggeryapps/admin/site/conf/site.json params
  $spec = '?' #UK or Berlin , common to openbanking.xml as well


  #nested variable issue , different database issue (configured only for mysql for now)
  if $dbms == 'mysql'{

    $DB_APIMGT_URL = 'jdbc:mysql://'${DB_HOST}':3306/'${DB_APIMGT}'?autoReconnect=true\&amp;useSSL=false',
    $DB_APIMGT_STAT_URL= 'jdbc:mysql://'${DB_HOST}':3306/'${DB_APIMGT_STAT}'?autoReconnect=true\&amp;useSSL=false',
    $DB_MB_STORE_URL = 'jdbc:mysql://'${DB_HOST}':3306/'${DB_MB_STORE}'?autoReconnect=true\&amp;useSSL=false',
    $DB_AM_CONFIG_URL ='jdbc:mysql://'${DB_HOST}':3306/'${DB_AM_CONFIG}'?autoReconnect=true\&amp;useSSL=false',
    $DB_GOV_URL = 'jdbc:mysql://'${DB_HOST}':3306/'${DB_GOV}'?autoReconnect=true\&amp;useSSL=false',
    $DB_USER_STORE_URL = 'jdbc:mysql://'${DB_HOST}':3306/'${DB_USER_STORE}'?autoReconnect=true\&amp;useSSL=false',
    
  }

  #open-banking-datasources.xml params

  if $dbms == 'mysql' {

    DB_OPEN_BANKING_STORE_URL = 'jdbc:mysql://'${DB_HOST}':3306/'${DB_OPEN_BANKING_STORE}'?autoReconnect=true\&amp;useSSL=false',
  }



  
  #template list

  $template_list = [
    'repository/conf/api-manager.xml', #Only change IAM_HOSTNAME here not OBAM_HOSTNAME
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/open-banking-datasources.xml',
    'repository/conf/carbon.xml',     #done
    'repository/conf/registry.xml',   #no changes in config
    'repository/conf/user-mgt.xml',   #no changes in config
    #'repository/conf/axis2/axis2.xml', not available in configure-am.sh
    'repository/deployment/server/executionplans/global_FreqPerDay.siddhiql',  #configuration changes removed in OBAM 1.4,therefore only a static file
    #replace_mysql7_file_names_as_mysql() in config.sh - files are already renamed in OBAM 1.4
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/open-banking-datasources.xml'
  ]

  


  



}
