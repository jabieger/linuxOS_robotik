# OSOS Ansible

Ansible files to set up a standard Ubuntu client.

## **Quick How-To**

**Prerequisites:** 

 - Ubuntu 20.04 with openssh-server installed and accessible from remote.


Download and extract or clone repository.

Make the necessary changes.

This should include the following files

- hosts
- vars/global_vars 
- roles/common/templates/policies.json.j2 if you need to change firefox settings


Usage:

~~~
ansible-playbook main.yml --ask-pass --ask-become-pass --extra-vars "@vars/global_vars.yml"
~~~

You can also pass the passwords using --extra-vars

~~~
ansible-playbook main.yml -extra-vars "ansible_ssh_pass=MYPASSWORD" --extra-vars "ansible_become_pass=MYPASSWORD" --extra-vars "@vars/global_vars.yml"
~~~

It is recommended to use [ansible vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) for passwords!

## Details
### hosts 
The hosts file consists of several sections. As we have 3 computer labs we have three sections called "EDV1, EDV2, EDV3".
Each section should contain the appropriate ip addresses or hostnames. 
The next section "KlassenPC" should contain all the ip addresses / hostnames of your machines in the classrooms. 
For grouping purposes there are two additional sections containing ":children". This makes it easier to execute a playbook on all computers.
The last part contains the variables. As they apply for all computers, the notation is \[all:vars\].
It is possible to have different variables for each section, though.
The hosts file should fit your purposes and can look a lot different than this one.

More details on the inventory can be found in the [documentation](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html) 

### global_vars
This file should speak for itself as the variables have meaninful names and some comments were added.

### roles 
Ansible roles just have the purpose to structure your playbooks. This simplifies writing complex playbooks and makes them easier to reuse. Currently there are three roles:
- **software**:
    Contains all sofware installation related information. Which packages will be installed. 3rd party software, which is not in the default repositories. Therefore it also contains the apt proxy config - if you have one configured, as well as the deb conf configuration.
- **common**: 
  Contains mainly the configuration information like cronjob, firefox policy, default apps, gnome settings, securing ssh a bit,... The tasks should speak for itself. 
- **cslab**: 
  Contains all the extra stuff that is applied to the computers in our labs. Veyon, autologin, different user password

Currently I am thinking of creating a 4th role, which will be used for ansible-pull. This still needs to be discussed.

### Packages
Which packages are installed?
The file _software/defaults/main.yml_ contains three variables:
- **main_software_packages**: 
All these packages are installed on any of our computers. Of course you can add package names that you are missing. However make sure they exist in the Ubuntu repositories or add additional repositories.
- **remove_software_packages**: 
Of course there are packages we want to uninstall. This variable contains them.
- **additional_software_packages_for_csr**: 
For the computers in our computer science room/lab we have additional requirements, which is reflected in this list of software packages. These packages are only installed if the ip address or hostname is part of the "EDV?" section of the hosts file.
