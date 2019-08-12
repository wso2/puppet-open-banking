class obkm::params {
	
	$packages = ["unzip"]

	#User Details
	$user = 'wso2carbon'
  	$user_group = 'wso2'
  	$user_id = 802
  	$user_group_id = 802

	# JDK Distributions
  	$java_dir = "/opt"
	$java_symlink = "${java_dir}/java"
  	$jdk_name = 'jdk1.8.0_161'
  	$java_home = "${java_dir}/${jdk_name}"

  	$target = "/mnt"
  	$product_dir = "${target}/${profile}"
  	$pack_dir = "${target}/${profile}/packs"

	$wso2_service_name = "wso2${profile}"

	$version = "1.4.0"
  	$pack = "wso2-obkm-${version}"

	# Pack Directories
	$product_binary = "${pack}.zip"
	$carbon_home = "${product_dir}/${pack}"

	$start_script_template = 'bin/wso2server.sh'
	$server_script_path = "${product_dir}/${pack}/bin/wso2server.sh"
	$pid_file_path = "${product_dir}/${pack}/wso2carbon.pid"

	
	# Configure databases related properties
	$db_type = "mysql"
	$db_host = "localhost"
	$db_user = "root"
	$db_pass = "root"
	$db_driver = "com.mysql.jdbc.Driver"

	$db_apimgt = "openbank_apimgtdb"
	$db_is_config = "openbank_iskm_configdb"
	$db_gov = "openbank_govdb"
	$db_user_store = "openbank_userdb"
	$db_open_banking_store = "openbank_openbankingdb" 
	
	#hostname configurations
	$iam_hostname = "localhost"
	$apim_hostname = "localhost"
	$analytics_hostname = "localhost"

	#jaggeryapps/admin/site/conf/site.json and openbanking.xml params
	$spec = "UK"

	# ----- datasources config params -----

	if $db_type == "mysql" {
		
		# ----- Open Banking datasources config params -----
		$db_open_banking_store_url = "jdbc:mysql://'${db_host}':3306/'${db_open_banking_store}'?autoReconnect=true\&amp;useSSL=false"

		# ----- Master-datasources config params -----
		$db_apimgt_url = "jdbc:mysql://${db_host}:3306/${db_apimgt}?autoReconnect=true\&amp;useSSL=false"
		$db_km_config_url = "jdbc:mysql://'${db_host}':3306/'${db_is_config}'?autoReconnect=true\&amp;useSSL=false"
		$db_gov_url = "jdbc:mysql://'${db_host}':3306/'${db_gov}'?autoReconnect=true\&amp;useSSL=false"
		$db_user_store_url = "jdbc:mysql://'${db_host}':3306/'${db_user_store}'?autoReconnect=true\&amp;useSSL=false"	

	} else {
		
		# ----- Open Banking datasources config params -----
		$db_open_banking_store_url = "jdbc:sqlserver://'${db_host}':1433;databaseName='${db_open_banking_store}';encrypt=false"

		# ----- Master-datasources config params -----
		$db_apimgt_url = "jdbc:sqlserver://'${db_host}':1433;databaseName='${db_apimgt}';encrypt=false"	
		$db_km_config_url = "jdbc:sqlserver://'${db_host}':1433;databaseName='${db_is_config}';encrypt=false"
		$db_gov_url = "jdbc:sqlserver://'${db_host}':1433;databaseName='${db_gov}';encrypt=false"
		$db_user_store_url = "jdbc:sqlserver://'${db_host}':1433;databaseName='${db_user_store}';encrypt=false"	
	}


	$template_list = [
		#configure_datasources
		"repository/conf/datasources/master-datasources.xml",
		"repository/conf/datasources/open-banking-datasources.xml",
		"repository/conf/carbon.xml",
		"repository/conf/registry.xml",
		"repository/conf/user-mgt.xml",	

		#change_dns
		"repository/conf/identity/identity.xml",
		"repository/conf/identity/application-authentication.xml",
		"repository/conf/finance/open-banking.xml",
		"repository/deployment/server/jaggeryapps/consentmgt/configs/conf.json",

		#configure speccarbon_homecarbon_home
		"repository/deployment/server/jaggeryapps/ccportal/configs/conf.json"	
	]

	#sql files
	$sqlfile_list = [
		"${carbon_home}/dbscripts/mysql5.7.sql ${carbon_home}/dbscripts/mysql.sql ",
		"${carbon_home}/dbscripts/apimgt/mysql5.7.sql ${carbon_home}/dbscripts/apimgt/mysql.sql",
		"${carbon_home}/dbscripts/consent/mysql-5.7.sql ${carbon_home}/dbscripts/consent/mysql.sql",
		"${carbon_home}/dbscripts/identity/mysql-5.7.sql ${carbon_home}/dbscripts/identity/mysql.sql",
		"${carbon_home}/dbscripts/identity/uma/mysql5.7.sql ${carbon_home}/dbscripts/identity/uma/mysql.sql",
		"${carbon_home}/dbscripts/finance/openbanking.org.uk/mysql-5-7.sql ${carbon_home}/dbscripts/finance/openbanking.org.uk/mysql.sql",
		"${carbon_home}/dbscripts/finance/berlin-group.org/mysql-5-7.sql ${carbon_home}/dbscripts/finance/berlin-group.org/mysql.sql",
		"${carbon_home}/dbscripts/finance/STET/mysql-5-7.sql ${carbon_home}/dbscripts/finance/STET/mysql.sql"	
	]
}
