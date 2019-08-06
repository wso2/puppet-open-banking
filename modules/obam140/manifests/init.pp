class obam140 inherits obam140::params{

  /* From apim::common */

  package { 'unzip': 
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
    require => Group["${user_group}"],
    notify => File["jdk-distribution"],
  }

  # Copy JDK to Java distribution path
  file { "jdk-distribution":
    path => "${java_home}.tar.gz",
    source => "puppet:///modules/${module_name}/jdk/${jdk_name}.tar.gz", #need to add jdk to the master
    notify => Exec["unpack-jdk"],
  }

  # Unzip distribution
  exec { "unpack-jdk":
    command => "tar -zxvf ${java_home}.tar.gz",
    path    => "/bin/",
    cwd     => "${java_dir}",
    onlyif  => "/usr/bin/test ! -d ${java_home}",
  }

  # Create symlink to Java binary
  file { "${java_symlink}":
    ensure  => "link",
    target  => "${java_home}",
    require => Exec["unpack-jdk"]
  }

  

  

  /*
  * WSO2 Distribution
  */

  #Create product folder and pack folder
  file { ["${product_dir}", "${pack_dir}"]:
    ensure  => directory,
    owner   => $user,
    group   => $user_group,
    require => [ User["${user}"], Group["${user_group}"] ]
  }

  # Copy binary to distribution path
   file { "wso2-binary":
      path    => "${pack_dir}/${product_binary}",
      owner   => $user,
      group   => $user_group,
      mode    => '0644',
      source  => "puppet:///modules/${module_name}/packs/${product_binary}",
      require => File["${product_dir}", "${pack_dir}"],
  #    notify  => [Exec["stop-server"], Exec["unzip-update"]],
    }


  # Unzip the binary and create setup
  exec { "unzip-update":
    command => "unzip -o ${product_binary} -d ${product_dir}",
    path    => "/usr/bin/",
    user    => $user,
    group   => $user_group,
    cwd     => "${pack_dir}",
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
    path        => '/bin/:/sbin/:/usr/bin/:/usr/sbin/',
    subscribe   => File["/etc/systemd/system/${wso2_service_name}.service"],
    refreshonly => true,
  }


  /* From apim */


  # Copy wso2server.sh to installed directory
  file { "${carbon_home}/${start_script_template}":
    ensure  => file,
    owner   => $user,
    group   => $user_group,
    mode    => '0754',
    content => template("${module_name}/carbon-home/${start_script_template}.erb"),
    notify  => Service["${wso2_service_name}"],
#    require => Class["apim_common"]           //original 
    require => Exec["unzip-update"],
  }



 /* from service.pp */

 service { "${wso2_service_name}":
    enable => true,
    ensure => running,
  }


}
