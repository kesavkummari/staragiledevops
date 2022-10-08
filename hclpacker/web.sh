#!/bin/bash

# Setup New Hostname
#hostnamectl set-hostname "ansible-controller.kesavkummari.com"

# Configure New Hostname as part of /etc/hosts file 
#echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts

# Update the Repository
sudo apt-get update

# Download, Install & Configure Ansible
sudo apt-get install software-properties-common -y 
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt-get install ansible -y 

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
