exec { "apt-get update":
     path => '/usr/bin',
} ->

package { 'default-jdk' }

package { "java7-jdk":
     ensure => present,
} -> 

class { 'solr' :
}

