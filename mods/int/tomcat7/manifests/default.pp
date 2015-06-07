
$catalina_download_url = "http://www.eu.apache.org/dist/tomcat/tomcat-7/v7.0.62/bin/apache-tomcat-7.0.62.tar.gz"
$catalina_archive = "apache-tomcat-7.0.62.tar.gz"
$catalina_home = "/opt/apache-tomcat-7.0.62"
$catalina_folder = "apache-tomcat-7.0.62"
$user = "tomcat"
$group = "tomcat"

exec { "apt-get update": path => "/usr/bin", }

package { "wget":
  ensure  => present,
  require => Exec["apt-get update"],
}

exec { "get_tomcat7":
  cwd       => "/tmp",
  timeout   => 900,
  path      => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"],
  command   => "wget --no-check-certificate --no-cookies ${catalina_download_url}",
  creates   => "/tmp/${catalina_archive}",
  require   => Package["wget"],
  logoutput => "on_failure"
}

user { "user_create":
    creates => "/home/$user",
    ensure    => present,
    comment   => "Tomcat User",
    home      => "/home/$user",
    shell     => "/bin/bash",
    gid    => $group,
    require => Exec["get_tomcat7"],
  }

group { "group_create": $group: ensure => present, require => user["user_create"], }

exec { "setup_tomcat7":
  owner     => "$user",
  mode      => 0755,
  recurse   => true,
  creates => "${catalina_home}",
  command => "tar xfvz /tmp/${catalina_archive}",
  path    => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"],
  cwd     => "/opt",
  require => group["group_create"],
}

file { "/etc/profile.d/java.sh":
  content => "export CATALINA_HOME=${catalina_home}
                  export PATH=\$PATH:\$CATALINA_HOME/bin",
  require => Exec['setup_tomcat7'],
}

file { "${catalina_home}/webapps":
  ensure  => directory,
  purge   => true,
  recurse => true,
  force   => true,
  require => Exec['setup_tomcat7'],
}

file { "${catalina_home}/conf/server.xml":
    ensure  => "present",
    target  => "/workspace/server.xml",
    require => Exec['setup_tomcat7'],
  }
  
  file { "${catalina_home}/bin/catalina.sh":
    owner     => "$user",
    mode      => 0755,
    ensure  => "present",
    target  => "/workspace/catalina.sh",
    require => Exec['setup_tomcat7'],
  }
  
  exec { "start_tomcat7":
  owner     => "$user",
  command => "${catalina_home}/bin/catalina.sh start",
  path    => ["/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/"],
  cwd     => "${catalina_home}/bin/",
  require => file["${catalina_home}/bin/catalina.sh"],
}