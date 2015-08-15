# = Class: solr::jetty
#
# This class manages the default jetty installation included with Apache Solr
#
# == Parameters:
#
#
# == Requires:
#
#
# == Sample Usage:
#
#
class solr::jetty(
  $solr_version = $solr::params::solr_version,
  $solr_home = $solr::params::solr_home,
  $zookeeper_hosts = $solr::params::zookeeper_hosts,
  $core_name = $solr::params::core_name,
) inherits solr::params {
  class { 'solr::core':
    core_name => $core_name 
  }

#  file { '/etc/init.d/solr':
#    ensure => present,
#    mode   => '0755',
#    source => 'puppet:///modules/solr/solr',
#    owner  => 'root',
#  } ->
  package { 'solrjetty':
      ensure  => present,
      require => [Apt::Source['trusty-solrjetty']]
  } ->

  service {'solr':
    ensure  => running,
    require => Class['solr::core']
  }
}
