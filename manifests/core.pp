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
#     core_name           => 'test'
#   }
#
class solr::core(
  $solr_version = $solr::params::solr_version,
  $solr_home = $solr::params::solr_home,
  $apache_mirror = $solr::params::apache_mirror,
  $core_name = $solr::params::core_name,
  $solr_conf = $solr::params::solr_conf,
  ) inherits solr::params {

# files/etc/solr/cores/sunspot
  file { "/etc/solr/${core_name}/":
    ensure  => directory,
    path    => "${solr_conf}/${core_name}/",
    recurse => true,
    purge   => false,
    mode    => '0644',
    owner   => solr,
    group   => solr,
    source  => "puppet:///modules/solr/etc/solr/cores/${core_name}/",
    require => [ Package['solrjetty'], Service['solr'] ]
  } ->

# unload default core
  exec { 'exec_curl_unload_collection1':
    command => "/usr/bin/curl --retry 10 --retry-delay 5 'http://localhost:8983/solr/admin/cores?wt=json&action=UNLOAD&core=collection1&_=1439695521370' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en,en-US;q=0.8,nl;q=0.6,af;q=0.4,fr;q=0.2' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://localhost:8983/solr/' -H 'X-Requested-With: XMLHttpRequest' -H 'Cookie: JSESSIONID=84253F84A1281068F11973475C553CDC' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed",
#    require => File["/etc/solr/${core_name}/"],
  } ->

# load custom core
  exec { "exec_curl_create_${core_name}":
    command => "/usr/bin/curl --retry 10 --retry-delay 5 'http://localhost:8983/solr/admin/cores?wt=json&indexInfo=false&action=CREATE&name=${core_name}&instanceDir=${core_name}&dataDir=%2Fdata%2Fsolr%2F${core_name}&config=solrconfig.xml&schema=schema.xml&collection=&shard=&_=1438349056610' -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en,en-US;q=0.8,nl;q=0.6,af;q=0.4,fr;q=0.2' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.134 Safari/537.36' -H 'Accept: application/json, text/javascript, */*; q=0.01' -H 'Referer: http://localhost:8983/solr/' -H 'X-Requested-With: XMLHttpRequest' -H 'Cookie: JSESSIONID=84253F84A1281068F11973475C553CDC' -H 'Connection: keep-alive' -H 'Cache-Control: no-cache' --compressed",
    creates => "/var/lib/${core_name}",
    #require => File["/etc/solr/${core_name}/"],
  }
}
