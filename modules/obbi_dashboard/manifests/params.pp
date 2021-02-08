#----------------------------------------------------------------------------
#  Copyright (c) 2020 WSO2, Inc. http://www.wso2.org
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

class obbi_dashboard::params inherits ob_common::params {

  # Start script template list
  $start_script_template  = 'bin/dashboard.sh'

  # Maximum and minimum memory sizes for JVM
  $jvmxms = '2048m'
  $jvmxmx = '2048m'

  # Template list
  $template_list = [
    'conf/dashboard/deployment.yaml',
    'deployment/siddhi-files/TRAAccountValidationApp.siddhi',
    'deployment/siddhi-files/TRAPaymentValidationApp.siddhi',
    'deployment/siddhi-files/FraudStatusUpdaterApp.siddhi',
    'resources/finance/cds-siddhi-files/GetInvocationDataApp.siddhi'
  ]

  # AU specific file to be removed
  $ob_report_generic_summarization_file = 'deployment/siddhi-files/OB_REPORT_GENERIC_SUMMARIZATION.siddhi'

  # Define file list
  $file_list = []

  # Define remove file list
  $file_removelist = []
}
