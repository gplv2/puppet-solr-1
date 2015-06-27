exec { "apt-get update":
     path => '/usr/bin',
} ->

package { "java7-jdk":
     ensure => present,
} -> 

package { 'openjdk-7-jdk':
    ensure => present,
} ->

package { 'libjetty-extra-java':
    ensure => present,
} ->

package { 'libtomcat7-java':
    ensure => present,
} ->

file { "/usr/java":
    ensure  =>  directory,
    owner   =>  'root',
    group   =>  'root',
    mode    =>  '0755',
    require => Package['openjdk-7-jdk'],
} ->

# Ensure the softlink to default java exists
file { "/usr/java/default":
    ensure  =>  'link',
    target  =>  '/usr/lib/jvm/java-7-openjdk-amd64',
    require => Package['openjdk-7-jdk'],
} ->

class { 'solr' :
}

