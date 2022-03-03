#!/bin/bash

ansible-playbook -i hosts --extra-vars "@vars/global_vars.yml" main.yml
