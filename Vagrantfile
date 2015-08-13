# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  ["jetty", "tomcat"].each do |puppet_base|
    [
      {
         name: "trusty64",
         url: "https://atlas.hashicorp.com/ubuntu/boxes/trusty64/versions/20150609.0.10/providers/virtualbox.box",
         port: 8985,
         cpu: 4,
         mem: 2048
      },
      {
         name: "precise64",
         url: "http://files.vagrantup.com/precise64.box",
         port: 8983,
         cpu: 1,
         mem: 1024
      },
      {
        name: "cent64",
        url: "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130731.box",
        port: 8984,
        cpu: 1,
        mem: 1024
      }
    ].each do |vm_info|
    # Configure VM Ram usage
      config.vm.define "#{vm_info[:name]}-#{puppet_base}" do |custom|

        custom.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--memory", vm_info[:mem]]
            v.customize ["modifyvm", :id, "--cpus", vm_info[:cpu]]
        end

        custom.vm.network :forwarded_port, guest: 8983, host: vm_info[:port]
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
  config.vm.synced_folder "/home/glenn/solrjetty_4.10-1", "/root/package"

end
