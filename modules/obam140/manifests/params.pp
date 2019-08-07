
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

  #template list

  $template_list = [
    'repository/conf/api-manager.xml', #done
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/open-banking-datasources.xml',
    'repository/conf/carbon.xml',     #done
    'repository/conf/registry.xml',   #no changes in config
    'repository/conf/user-mgt.xml',   #no changes in config
    #'repository/conf/axis2/axis2.xml', not available in configure-am.sh
    # 'repository/deployment/server/executionplans/global_FreqPerDay.siddhiql',  #removed in OBAM 1.4
  ]



}
