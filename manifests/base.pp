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

    file { '/data/solr':
      ensure => directory,
      owner  => solr,
    } ->

    user { 'solr':
      ensure => present
    } ->

    file { $solr_home:
      ensure => directory,
      owner  => solr,
    }
}
