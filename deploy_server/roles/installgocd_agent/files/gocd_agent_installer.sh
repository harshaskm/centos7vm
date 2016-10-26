#!/bin/bash

# This is a piece of code from: https://docs.go.cd/16.5.0/installation/install/agent/linux.html
echo "
[gocd]
name     = GoCD YUM Repository
baseurl  = https://download.go.cd
enabled  = 1
gpgcheck = 1
gpgkey   = https://download.go.cd/GOCD-GPG-KEY.asc
" | sudo tee /etc/yum.repos.d/gocd.repo

sudo yum install -y java-1.7.0-openjdk #optional, you may use other jre/jdk if you prefer
sudo yum install -y go-agent

