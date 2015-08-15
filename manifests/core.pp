# = Class: solr::core
#
# This class downloads and installs a Apache Solr
#
# == Parameters:
#
# $solr_version:: which version of solr to install
#
# $solr_home:: where to place solr
#
#
# == Requires:
#
#   wget
#
# == Sample Usage:
#
#   class {'solr::core':
#     solr_version           => '4.10.4'
#   }
#
class solr::core(
  $solr_version = $solr::params::solr_version,
  $solr_home = $solr::params::solr_home,
  $apache_mirror = $solr::params::apache_mirror,
  $core_name = $solr::params::core_name,
  ) inherits solr::params {

 file { '/etc/solr/':
    source  => "puppet:///files/etc/solr/cores/*",
#   require => File["/etc/solr"],
    ensure  => directory,
    recurse => true,
    purge   => false,
    mode    => 0644,
    owner   => jetty,
    group   => jetty,
#   notify => Exec["restart-jetty"];
#    require => Service["solr"],
  }


#  file { '/data':
#    ensure => directory,
#    owner  => root,
#  } ->

#  user { 'solr':
#    ensure => present
#  } ->

#  file { '/data/solr':
#    ensure => directory,
#    owner  => solr,
#  } ->

#  file { "${solr_home}":
#    ensure => directory,
#    owner  => solr,
#  } ->

#  file { "${solr_home}/current":
#    ensure => link,
#    target => "${solr_home}/solr-${solr_version}",
#    owner  => solr,
#  }

# defaults if solr_conf is not provided
# data will go to /data/solr
# conf will go to /etc/solr
#  file { '/etc/solr':
#    ensure => directory,
#    owner  => solr,
#  } ->

#  file { '/etc/solr/solr.xml':
#    ensure => present,
#    source => 'puppet:///modules/solr/solr.xml',
#    owner  => solr,
#  } ->
#  file { '/etc/solr/collection1':
##    ensure  => directory,
#    owner   => solr,
#    require => Exec['dpkg solr']
#  } ->
#
#  file { '/etc/solr/collection1/conf':
#    ensure => directory,
#    owner  => solr,
#  } ->
#  file { '/data/solr/collection1':
#    ensure => directory,
#    owner  => solr,
#  } ->

#  exec { 'copy core files to collection1':
#    command => "cp -rf ${solr_home}/current/example/solr/collection1/* /etc/solr/collection1/",
#    user    => solr,
#    creates => '/etc/solr/collection1/conf/schema.xml'
#  }
}
