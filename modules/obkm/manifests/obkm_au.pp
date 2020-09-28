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

class obkm::obkm_au inherits obkm::params{

include stdlib

if ($spec =="AU")  {

notify{"Executing Spec ${spec} for OBKM":}
#OBKM Config Edits for AU Spec

file_line {'editing AU spec UserAccessTokenDefaultValidityPeriod, obkm identity.xml' :
  path  => $obkm_identity,
  line   => '<UserAccessTokenDefaultValidityPeriod>120</UserAccessTokenDefaultValidityPeriod>',
  match => '<UserAccessTokenDefaultValidityPeriod>',
  append_on_no_match => false,
}

file_line {'editing AU spec ValidateAccountIdOnRetrieval, open-banking.xml' :
  path  => $obkm_openbanking,
  line   => '<ValidateAccountIdOnRetrieval>true</ValidateAccountIdOnRetrieval>',
  match => '<ValidateAccountIdOnRetrieval>',
  append_on_no_match => false,
}

file_line {'editing AU spec EnableMTLSTokenBinding, open-banking.xml' :
  path  => $obkm_openbanking,
  line   => '<EnableMTLSTokenBinding>true</EnableMTLSTokenBinding>',
  match => '<EnableMTLSTokenBinding>',
  append_on_no_match => false,
}

file_line {'Appending AU spec EventListener, identity.xml' :
  path  => $obkm_identity,
  line   => '<EventListener enable="true" name="com.wso2.finance.open.banking.identity.extensions.listeners.TokenRevocationListener" orderId="100" type="org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"/>',
  after => '<EventListeners>',
  multiple => false,
  match   => '<EventListener enable="true" name="com.wso2.finance.open.banking.identity.extensions.listeners.TokenRevocationListener" orderId="100" type="org.wso2.carbon.identity.core.handler.AbstractIdentityHandler"/>',
}

file_line {'editing AU spec ClientAuthenticationHeader, open-banking.xml' :
  path  => $obkm_openbanking,
  line   => '<ClientAuthenticationHeader>x-wso2-mutual-auth-cert</ClientAuthenticationHeader>',
  after => '<CertificateManagement>',
  multiple => false,
  match   => '<ClientAuthenticationHeader>',
}

file_line {'Updating identity.xml to display the DCR endpoint in OpenID Connect Discovery, identity.xml' :
  path  => $obkm_identity,
  line   => '<OAuth2DCREPUrl>${carbon.protocol}://localhost:8243/open-banking/0.1/register</OAuth2DCREPUrl>',
  match => '<OAuth2DCREPUrl>',
  append_on_no_match => false,
}

}else {
  notify{"Default Spec ${spec}":}
}

}
