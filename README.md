puppet-solr
===========

Puppet module for installing solr with a stand alone jetty server.  The server will default to port 8985 and store it's data in /var/lib/solr.  Configuration files can be found at /etc/solr.  

This install has been tested on:

* Ubuntu 14.04

Using this manifest
-----------

You'll need to build your own package from the tar sources of solr-jetty first.  The build scripts can be found here... LINKHERE

1. Check out this repository in your modules directory
2. Jetty will pick java 7 explicitely since it runs much better on this version.

```pp

class {'solr::jetty': }

include solr

```
3. To see your server running visit http://localhost:8985/solr/#
4. For a slightly more full featured example manifest see example.pp


Vagrant testing 
---------------

retry a puppet apply run: adjust the uuid's first... see `df -k`

/usr/bin/ruby /usr/bin/puppet apply --verbose --debug --modulepath /tmp/vagrant-puppet/modules-14cf72675f3ef26a2925e2485cd1dd79:/etc/puppet/modules --detailed-exitcodes --manifestdir /tmp/vagrant-puppet/manifests-5058f1af8388633f609cadb75a75dc9d /tmp/vagrant-puppet/manifests-5058f1af8388633f609cadb75a75dc9d/jetty.pp 


Working with Solr Cloud
-----------------------
solr::jetty can be used to host solrCloud.

```pp

class {'solr::jetty':
  zookeeper_hosts        => ["example.com:2181", "anotherserver.org:2181/alternate_root"]
}
```

TODO
----
- include build script sources
