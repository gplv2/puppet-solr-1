# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  ["jetty", "tomcat"].each do |puppet_base|
    [
      {
         name: "trusty64",
         url: "https://atlas.hashicorp.com/ubuntu/boxes/trusty64/versions/20150609.0.10/providers/virtualbox.box",
         port: 8985
      },
      {
         name: "precise64",
         url: "http://files.vagrantup.com/precise64.box",
         port: 8983
      },
      {
        name: "cent64",
        url: "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box",
        port: 8984
      }
    ].each do |vm_info|
      config.vm.define "#{vm_info[:name]}-#{puppet_base}" do |custom|
        custom.vm.network :forwarded_port, guest: 8983, host: vm_info[:port]
        v.memory = 1024
        v.cpus = 2
        custom.vm.box = vm_info[:name]
        custom.vm.box_url = vm_info[:url]
        custom.vm.provision :puppet do |puppet|
          puppet.manifests_path  = "."
          puppet.manifest_file  = "#{puppet_base}.pp"
#          puppet.options = ['--verbose','--debug']
          puppet.options = ['--verbose']
        end
      end

    end
  end

  config.vm.synced_folder ".", "/etc/puppet/modules/solr"


end
