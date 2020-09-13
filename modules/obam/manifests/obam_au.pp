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

class obam::obam_au inherits obam::params{

include stdlib

if ($spec =="AU")  {
notify{"Executing Spec ${spec} for OBAM":}
#OBAM Config Edits for AU Spec

file_line {'editing AU spec PrimaryAuthenticator, open-banking.xml' :
  path  => $obam_openbanking ,
  line   => '<SCA><PrimaryAuthenticator> <Name>IdentifierExecutor</Name> <DisplayName>identifier-first</DisplayName> </PrimaryAuthenticator></SCA>',
  after => '<Server>',
  multiple => false,
  match => '<SCA><PrimaryAuthenticator> <Name>IdentifierExecutor</Name> <DisplayName>identifier-first</DisplayName> </PrimaryAuthenticator></SCA>',
}

file_line {'appending AU handler class, _TokenAPI_.xml' :
  path  => $obam_tokenapi ,
  line   => '<handler class="com.wso2.finance.open.banking.mtls.validator.handler.GatewayClientAuthenticationHandler"/>',
  after => '<handlers>',
  match => '<handler class="com.wso2.finance.open.banking.mtls.validator.handler.GatewayClientAuthenticationHandler"/>',
  multiple => false,
}

}else {
  notify{"Default Spec ${spec}":}
}

}
