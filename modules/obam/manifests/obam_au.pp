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

notify{"Executing Spec ${spec} for OBAM":}
#OBAM Config Edits for AU Spec

file_line {'editing AU spec PrimaryAuthenticator, open-banking.xml' :
  path  => $obam_openbanking ,
  line   => '<SCA><PrimaryAuthenticator> <Name>IdentifierExecutor</Name> <DisplayName>identifier-first</DisplayName> </PrimaryAuthenticator></SCA>',
  after => '<Server>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with software_id_sandbox, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>software_id_sandbox</Name> <Description>Software ID of the sandbox</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with software_id_production, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>software_id_production</Name> <Description>Software ID of the production</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with software_roles_sandbox, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>software_roles_sandbox</Name> <Description>Software roles of the sandbox</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with software_roles_production, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>software_roles_production</Name> <Description>Software roles of the production</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with software_jwks_endpoint_sandbox, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>software_jwks_endpoint_sandbox</Name> <Description>JWKS endpoint of sandbox</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with software_jwks_endpoint_production, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>software_jwks_endpoint_production</Name> <Description>JWKS endpoint of production</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with org_id_sandbox, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>org_id_sandbox</Name> <Description>Organization ID of the sandbox</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with org_id_production, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>org_id_production</Name> <Description>Organization ID of the production</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with scope_sandbox, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>scope_sandbox</Name> <Description>Allowed scopes for sandbox</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

file_line {'Updating api-manager.xml attributes with scope_production, api-manager.xml' :
  path  => $obam_apimanager ,
  line   => '<Attribute required="false"> <Name>scope_production</Name> <Description>Allowed scopes for production</Description> </Attribute>',
  after => '<ApplicationAttributes>',
  multiple => false,
}

}
