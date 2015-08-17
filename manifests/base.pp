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
#   class {'solr::base':
#     solr_version           => '4.10.4'
#   }
#
class solr::base(
  $solr_version = $solr::params::solr_version,
  $solr_home = $solr::params::solr_home,
  $solr_conf = $solr::params::solr_conf,
  ) inherits solr::params {
    file { '/data':
      ensure => directory,
      owner  => root,
    } ->
# check to see if base data dir exists
    file { '/data/solr':
      ensure  => directory,
      require => Package['solrjetty'],
      owner   => solr,
    } ->

# check to see if solr user dir exists
    user { 'solr':
      ensure => present
    } ->

# check to see if solr home dir exists
    file { "${solr_home}":
      ensure => directory,
      owner  => solr,
    }
}
