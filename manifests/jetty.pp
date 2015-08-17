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
  class { 'solr::base':
    solr_version => $solr_version
  }

  package { 'solrjetty':
      ensure  => present,
      require => [Apt::Source['trusty-solrjetty']]
  } 

  service {'solr':
    ensure    => running,
    enable    => true,
    start    => "/etc/init.d/solr start",
    restart   => "/etc/init.d/solr restart",
    status     => "/etc/init.d/solr check",
    stop      => "/etc/init.d/solr stop",
    hasstatus => true,
    hasrestart => true,
    pattern => "/usr/bin/java -Dsolr.solr.home",
    require => [ Class['solr::base'] , Package['solrjetty'] ]
  }
}
