exec { "apt-get update":
     path => '/usr/bin',
} ->

package { 'default-jdk':
     ensure => present,
} ->

package { "java7-jdk":
     ensure => present,
} -> 

class { 'solr' :
}

