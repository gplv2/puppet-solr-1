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
#     solr_version           => '5.2.1'
#   }
#
class solr::core(
  $solr_version = $solr::params::solr_version,
  $solr_home = $solr::params::solr_home,
  $apache_mirror = $solr::params::apache_mirror,
  $core_name = $solr::params::core_name,
) inherits solr::params {
  # using the 'creates' option here against the
  # finished product so we only download this once
  # wget http://apache.cu.be/lucene/solr/5.2.1/solr-5.2.1.tgz
  # http://192.168.1.111/solr/solr-5.2.1.tgz

#==> trusty64-jetty: (Exec[untar solr] => File[/opt/solr/current] => File[/etc/solr] => File[/etc/solr/solr.xml] => File[/data] => File[/data/solr] => Exec[untar solr])

  #$solr_tgz_url = "http://${apache_mirror}/lucene/solr/${solr_version}/solr-${solr_version}.tgz"
  $solr_tgz_url = "http://192.168.1.111/solr/solr-${solr_version}.tgz"

  file { '/data':
    ensure => directory,
    owner  => root,
  } ->

  user { 'solr':
    ensure => present
  } ->

  file { "${solr_home}":
    ensure => directory,
    owner  => solr,
  } ->

  exec { 'wget solr':
    command => "wget --output-document=/usr/local/src/solr-${solr_version}.tgz ${solr_tgz_url}",
    creates => "${solr_home}/solr-${solr_version}",
  } ->

  file { '/data/solr':
    ensure => directory,
    owner  => solr,
  } ->

  exec { 'untar solr':
    command => "tar -xzf /usr/local/src/solr-${solr_version}.tgz -C ${solr_home}",
    creates => "${solr_home}/solr-${solr_version}",
  } ->

  file { "${solr_home}/current":
    ensure => link,
    target => "${solr_home}/solr-${solr_version}",
    owner  => solr,
  }

  # defaults if solr_conf is not provided
  # data will go to /var/lib/solr
  # conf will go to /etc/solr
  file { '/etc/solr':
    ensure => directory,
    owner  => solr,
  } ->

  file { '/etc/solr/solr.xml':
    ensure => present,
    source => 'puppet:///modules/solr/solr.xml',
    owner  => solr,
  }

  if $solr_version < '5.0.0' {
    file { '/etc/solr/collection1':
        ensure  => directory,
        owner   => solr,
    } ->

    file { '/etc/solr/collection1/conf':
        ensure => directory,
        owner  => solr,
    } ->
    file { '/data/solr/collection1':
        ensure => directory,
        owner  => solr,
    } ->

    file { '/var/lib/solr/collection1':
        ensure => directory,
        owner  => solr,
    } ->

    exec { 'copy core files to collection1':
        command => "cp -rf ${solr_home}/current/example/solr/collection1/* /etc/solr/collection1/",
        user    => solr,
        creates => '/etc/solr/collection1/conf/schema.xml'
    }
  } else {
     if $solr_version >= '5.0.0' {
        file { '/etc/solr/techproducts':
            ensure  => directory,
            owner   => solr,
        } ->
        exec { 'create example with solr binary':
           command => "${solr_home}/current/bin/solr start -e techproducts",
           user    => root,
        }
     }
  }
}

