#!/bin/bash

# Destroy and rebuild the vm which would host the gocd server
  cd /Users/hmohan/centos7vm
  time vagrant destroy -f gocdOnCentos7
  time vagrant up gocdOnCentos7

# Executing the yml files to download, install and configure the gocd_server
  cd /Users/hmohan/centos7vm/deploy_gocd
  export ANSIBLE_HOST_KEY_CHECKING=False
  time ansible-playbook -i gocd_ansible_hosts gocd_playbook.yml -vvvv

