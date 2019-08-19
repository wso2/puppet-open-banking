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

class obkm140 inherits obkm140::params {

  # Install system packages
  package { $packages:
    ensure => installed
  }

  # Create wso2 group
  group { $user_group:
    ensure => present,
    gid    => $user_group_id,
    system => true,
  }

  # Create wso2 user
  user { $user:
    ensure  => present,
    uid     => $user_id,
    gid     => $user_group_id,
    home    => "/home/${user}",
    system  => true,
    require => Group[$user_group],
    notify  => File['jdk-distribution']
  }

  # Java distribution

  # Copy JDK to Java distribution path
  file { 'jdk-distribution':
    path   => "${java_home}.tar.gz",
    source => "puppet:///modules/${module_name}/jdk/${jdk_name}.tar.gz",
    notify => Exec['unpack-jdk']
  }

  # Unzip distribution
  exec { 'unpack-jdk':
    command     => "tar -zf ${java_home}.tar.gz",
    path        => '/bin/',
    cwd         => $java_dir,
    onlyif      => "/usr/bin/test ! -d ${java_home}",
    subscribe   => File['jdk-distribution'],
    refreshonly => true
  }

  # Create symlink to Java binary
  file { $java_symlink:
    ensure  => 'link',
    target  => $java_home,
    require => Exec['unpack-jdk']
  }

  # WSO2 distribution

  # Create product folder and pack folder
  file { [$product_dir, $pack_dir]:
    ensure  => directory,
    owner   => $user,
    group   => $user_group,
    require => [ User[$user], Group[$user_group] ]
  }

  # Copy binary to distribution path
  file { 'wso2-binary':
    path    => "${pack_dir}/${product_binary}",
    owner   => $user,
    group   => $user_group,
    mode    => '0644',
    source  => "puppet:///modules/${module_name}/packs/${product_binary}",
    require => File[$product_dir, $pack_dir]
  }

  # Unzip the binary and create setup
  exec { 'unzip-update':
    command     => "unzip ${product_binary} -d ${product_dir}",
    path        => '/usr/bin/',
    user        => $user,
    group       => $user_group,
    cwd         => $pack_dir,
    subscribe   => File['wso2-binary'],
    refreshonly => true,
  }

  # Copy the unit file required to deploy the server as a service
  file { "/etc/systemd/system/${wso2_service_name}.service":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => '0754',
    content => template("${module_name}/carbon.service.erb"),
  }

  exec { 'systemctl daemon-reload':
    path        =>  '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    subscribe   => File["/etc/systemd/system/${wso2_service_name}.service"],
    refreshonly => true,
  }

  # Configuration Changes

  # Copy configuration changes to the installed directory
  $template_list.each |String $template| {
    file { "${carbon_home}/${template}":
      ensure  => file,
      mode    => '0644',
      content => template("${module_name}/carbon-home/${template}.erb"),
      notify  => Service[$wso2_service_name]
    }
  }

  # Copy wso2server.sh to installed directory
  file { "${carbon_home}/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb"),
    notify  => Service[$wso2_service_name],
    require => Exec['unzip-update']
  }

  service { $wso2_service_name:
    ensure => running,
    enable => true,
  }

}
