
exec { "apt-get update": path => "/usr/bin", }

package { "git":
  ensure  => present,
  require => Exec["apt-get update"],
}

package { "wget":
  ensure  => present,
  require => Exec["apt-get update"],
}

include java7,tomcat7



#class { '::java7':}class { '::tomcat7':}

