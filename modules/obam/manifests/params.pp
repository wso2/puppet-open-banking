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

class obam::params inherits ob_common::params{

  $start_script_template  = 'bin/wso2server.sh'
  
  #File paths obam
  $obam_openbanking = "${product_dir}/${pack}/repository/conf/finance/open-banking.xml"
  $obam_tokenapi = "${product_dir}/${pack}/repository/deployment/server/synapse-configs/default/api/_TokenAPI_.xml"
  $obam_apimanager = "${product_dir}/${pack}/repository/conf/api-manager.xml"
  $obam_swagger = "${product_dir}/${pack}/repository/deployment/server/jaggeryapps/store/site/themes/wso2/templates/api/swagger/template.jag"
  $obam_header = "${product_dir}/${pack}/repository/deployment/server/jaggeryapps/store/site/themes/wso2/subthemes/wso2-open-banking/templates/menu/header/template.jag"
  $obam_application_key ="${product_dir}/${pack}/repository/deployment/server/jaggeryapps/store/site/themes/wso2/subthemes/wso2-open-banking/templates/application/application-keys/template.jag"
  $obam_generate_jwt ="${product_dir}/${pack}/repository/deployment/server/jaggeryapps/store/site/blocks/generate-jwt/ajax/generate-jwt.jag"
  $obam_token_generator="${product_dir}/${pack}/repository/components/dropins/com.wso2.finance.open.banking.token.generator-1.5.0.jar"
  
  #--------------------------------------------------
  $obam_open_banking_common="${product_dir}/${pack}/repository/components/plugins/com.wso2.finance.open.banking.common_1.5.0.jar"

  # Maximum and minimum memory sizes for JVM
  $jvmxms = '2048m'
  $jvmxmx = '2048m'

  # jaggeryapps/admin/site/conf/site.json params
  $work_flow_server_url = "https://${bps_hostname}:9445/services/"

  # template list
  $template_list = [
    'repository/conf/api-manager.xml',
    'repository/conf/datasources/master-datasources.xml',
    'repository/conf/datasources/open-banking-datasources.xml',
    'repository/conf/carbon.xml',
    'repository/conf/registry.xml',
    'repository/conf/user-mgt.xml',
    'repository/resources/api_templates/velocity_template.xml',
    'repository/conf/finance/open-banking.xml',
    'repository/deployment/server/executionplans/global_FreqPerDay.siddhiql',
    'repository/deployment/server/jaggeryapps/admin/site/conf/site.json',
    'repository/deployment/server/jaggeryapps/store/site/conf/site.json',
  ]

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []
}
