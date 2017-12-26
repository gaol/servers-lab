# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  # config.vm.box_url = "https://dl.dropboxusercontent.com/u/3318148/vagrant/CentOS-6.4-x86_64-v2.box"

  config.vm.provider :virtualbox do |vb|
    # vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.memory = "2048"
    vb.cpus = 2
  end
  config.vm.provision "shell", path: "vboxguest.sh"
  config.vm.provision "ansible_local" do |ansible|
    ansible.galaxy_role_file = 'requirements.yml'
    #ansible.galaxy_roles_path = '/etc/ansible/roles'
    #ansible.galaxy_command = 'ansible-galaxy install --role-file=%{role_file} --roles-path=/etc/ansible/roles --force'
    ansible.playbook = "development.yml"
  end
  # config.vm.network "forwarded_port", guest: 8080, host: 18080, auto_correct: true
  config.vm.network "public_network", ip: "192.168.1.200", bridge: "wlp4s0"
end
