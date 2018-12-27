# Base4Kids2 Ansible Roles
This repository holds Ansible roles used in the base4kids project (work in progress). Currently, the infrastructure comprises the following software components and/or products:
* Mattermost
* LDAP
* Nextcloud
* Collabora Online

## Local Test Environment
The roles can be tested as documented in the [Adfinis Sygroup Ansible Guide](https://github.com/adfinis-sygroup/ansible-guide). For example, a Vagrantfile to test the galera and proxysql roles looks as follows:
```
Vagrant.configure("2") do |config|
  config.vm.synced_folder "~/.base4kids", "/home/vagrant/.base4kids"
  config.ssh.insert_key = false

  config.vm.box = "adsy-centos-7.4.1708.box"
  config.vm.box_url = "https://vagrant.adfinis-sygroup.ch/virtualbox-adsy-centos-7.4.1708.box"
  config.vm.box_download_checksum = "1a21b70a2b931ba68b8b7e1b8dc64b56f1d3571e3ab39ab9faf33dbb43a1ef12"
  config.vm.box_download_checksum_type = "sha256"

  config.vm.define "galera-01" do |g|
    g.vm.network "private_network", ip: "192.168.56.3"
  end
  config.vm.define "galera-02" do |g|
    g.vm.network "private_network", ip: "192.168.56.4"
  end
  config.vm.define "galera-03" do |g|
    g.vm.network "private_network", ip: "192.168.56.5"
  end

  config.vm.define "proxysql-01" do |g|
    # eth0
    g.vm.network "private_network", ip: "192.168.56.10"
    # keepalived interface (eth1)
    g.vm.network "private_network", type: "dhcp"
  end
  config.vm.define "proxysql-02" do |g|
    # eth0
    g.vm.network "private_network", ip: "192.168.56.11"
    # keepalived interface (eth1)
    g.vm.network "private_network", type: "dhcp"
  end

  config.vm.provider :virtualbox do |vb|
        vb.memory = 1024
        vb.cpus = 2
  end
end
```

Append the following to your `ansible.cfg` to allow Ansible logins on the test machine:
```
remote_user = vagrant
private_key_file = ~/.vagrant.d/insecure_private_key
host_key_checking = False
```

As an alternative to the [Vagrant Ansible Provisioner](https://www.vagrantup.com/docs/provisioning/ansible.html), the roles can be tested using the `ansible-playbook` command:
```
# -k: --ask-pass, ask for connection password, use if no 'ansible_ssh_private_key_file'
# -b: --become, run operations with become (does not imply password prompting)
# -K: --ask-become-pass, ask for privilege escalation password
ansible-playbook site.yml -i ./hosts-dev -l galera,proxysql -bkK
```

## Ansible Conventions
* The roles follow the Adfinis Sygroup conventions from the [Ansible Guide](https://github.com/adfinis-sygroup/ansible-guide) and are applied whenever possible.
* This repository pulls in other roles as dependecies as defined in `requirements.yml`. More roles can be found in [Ansible Galaxy](https://galaxy.ansible.com/adfinis-sygroup/).
