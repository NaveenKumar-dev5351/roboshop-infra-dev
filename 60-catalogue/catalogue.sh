#!/bin/bash

set -x  # print commands
set -e  # exit on error

component=$1
dnf install ansible -y
ansible-pull -U https://github.com/NaveenKumar-dev5351/ansible-roboshop-roles.git -e component=$1 main.yaml