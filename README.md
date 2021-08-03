# OSOS Ansible

Ansible Files to set up a standard client.

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

