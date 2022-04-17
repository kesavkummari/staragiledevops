#!/bin/bash

# Setup Hostname 
sudo hostnamectl set-hostname "web.staragile.com"

# Update the hostname part of Host File
echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts 

# Update Ubuntu Repository 
apt-get update 

# Download, Install & Configure Web Server i.e. Apache2 
apt-get install apache2 -y 

# Deploy a simple Website Part of DocumentRoot 
echo "Welcome to StarAgile AWS DevOps" > /var/www/html/index.html 

# SSM Agent Restart
sudo systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent.service

# Download, Install Java 11
sudo apt-get install openjdk-11-jdk -y

# Backup the Environment File
sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"

# Create Environment Variables 
echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment

# Compile the Configuration 
source /etc/environment

# Execute .war commandline
nohup java -jar /home/ubuntu/cloudbinary-5.0.0.war &

# Attach Instance profile To EC2 Instance 
# aws ec2 associate-iam-instance-profile --iam-instance-profile Name=EC2-SSM --instance-id i-09ab3febd8e5c3e0b --profile devops

