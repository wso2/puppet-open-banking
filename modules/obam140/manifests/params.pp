
class obam140::params {



  $user = 'wso2carbon'
  $user_group = 'wso2'
  $user_id = 802
  $user_group_id = 802

  $java_dir = "/opt"
  $jdk_name = "jdk-8u161-linux-x64"

  

  $target = "/mnt"
  $product_dir = "${target}/${profile}"
  $pack_dir = "${target}/${profile}/packs"


  $version = "1.3.0"
  $pack = "wso2-obam-${version}"
  $product_binary = "${pack}.zip"
}
