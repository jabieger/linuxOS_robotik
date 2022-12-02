#!/bin/bash

ansible-playbook -i hosts --extra-vars "@vars/global_vars.yml" main.yml

#ansible-playbook main.yml --ask-pass --ask-become-pass --extra-vars "@vars/global_vars.yml" --tags island

