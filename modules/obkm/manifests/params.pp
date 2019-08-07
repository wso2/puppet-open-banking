class obkm::params {
	
	$packages = ["unzip"]

	$user = 'wso2carbon'
  	$user_group = 'wso2'
  	$user_id = 802
  	$user_group_id = 802

	# JDK Distributions
  	$java_dir = "/opt"
	$java_symlink = "${java_dir}/java"
  	$jdk_name = 'jdk1.8.0_161'
  	$java_home = "${java_dir}/${jdk_name}"

	$profile = $profile
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

}
