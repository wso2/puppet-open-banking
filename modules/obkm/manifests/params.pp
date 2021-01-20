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

class obkm::params inherits ob_common::params {

  $start_script_template  = 'bin/wso2server.sh'
  
  #File paths obkm
  $obkm_identity = "${product_dir}/${pack}/repository/conf/identity/identity.xml"
  $obkm_openbanking = "${product_dir}/${pack}/repository/conf/finance/open-banking.xml"
  $obkm_apimanager = "${product_dir}/${pack}/repository/conf/api-manager.xml"

  # Maximum and minimum memory sizes for JVM
  $jvmxms = '2048m'
  $jvmxmx = '2048m'

  # Template list
  $template_list = [
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/open-banking-datasources.xml',
    'repository/conf/carbon.xml',
    'repository/conf/axis2/axis2.xml',
    'repository/conf/registry.xml',
    'repository/conf/user-mgt.xml',
    'repository/conf/tomcat/catalina-server.xml',
    'repository/conf/identity/identity.xml',
    'repository/conf/identity/application-authentication.xml',
    'repository/conf/finance/open-banking.xml',
    'repository/deployment/server/jaggeryapps/consentmgt/configs/conf.json',
    'repository/deployment/server/jaggeryapps/ccportal/configs/conf.json'
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []
}
