# = Class: solr::params
#
# This class manages the default jetty params 
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
class solr::params {

  case  $::osfamily {
    'Debian', 'Redhat': {
      #$solr_version = '5.2.1'
      $solr_version = '4.10.4'
      $solr_home = '/opt/solr'
      $apache_mirror = 'apache.cu.be'
      $zookeeper_hosts = ''
      $exec_path = '/usr/bin:/usr/sbin:/bin:/usr/local/bin:/opt/local/bin'
      $java_home = '/usr/lib/jvm/default-java'
      $core_name = 'sunspot'
      $solr_conf = '/etc/solr'
    }
    default: { fail('Running on an untested OS bailing out') }
  }
  # WARNING
  # We specify global path for every exec command in this class here
  Exec {
    path => $exec_path
  }
}
