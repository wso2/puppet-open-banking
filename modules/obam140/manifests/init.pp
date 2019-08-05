class obam140 inherits obam140::params{

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
    require => Group["${user_group}"]
  }

  # Copy JDK to Java distribution path
  file { "jdk-distribution":
    path => "${java_dir}/${jdk_name}",
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






}
