#----------------------------------------------------------------------------
#  Copyright (c) 2021 WSO2, Inc. http://www.wso2.org
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

class obam::obam_demo inherits obam::params{

  #Puppet scripts to update templates for OBAM demo site deployment.
  notify{"Executing OBAM Demo site template replacement":}

  file { $obam_swagger:
      mode => "0644",
      owner => 'root',
      group => 'root',
      source => 'puppet:///modules/obam/swagger.jag',
  }

  file { $obam_header:
      mode => "0644",
      owner => 'root',
      group => 'root',
      source => 'puppet:///modules/obam/header.jag',
  }

  file { $obam_application_key:
      mode => "0644",
      owner => 'root',
      group => 'root',
      source => 'puppet:///modules/obam/application-keys.jag',
  }

  file { ["${product_dir}/${pack}/repository/deployment/server/jaggeryapps/store/site/blocks/generate-jwt/",
  "${product_dir}/${pack}/repository/deployment/server/jaggeryapps/store/site/blocks/generate-jwt/ajax/"]:
      ensure => directory,
      owner => 'root',
      group => 'root',
      mode   => '0755'
  }

  file { $obam_generate_jwt:
      mode => "0644",
      owner => 'root',
      group => 'root',
      source => 'puppet:///modules/obam/generate-jwt.jag',
  }

  file { $obam_token_generator:
      mode => "0644",
      owner => 'root',
      group => 'root',
      source => 'puppet:///modules/obam/com.wso2.finance.open.banking.token.generator-1.5.0.jar',
  }

  file { $obam_open_banking_common:
      mode => "0644",
      owner => 'root',
      group => 'root',
      source => 'puppet:///modules/obam/com.wso2.finance.open.banking.common-1.5.0.jar',
  }
}
