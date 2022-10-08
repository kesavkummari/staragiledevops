#!/bin/bash

# Setup Hostname 
sudo hostnamectl set-hostname "tomcat.devops.com"

# Update the hostname part of Host File
echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts 

# Update Ubuntu Repository 
sudo apt-get update 

# Download, & Install Utility Softwares 
sudo apt-get install git wget unzip curl tree -y 

# Download, Install Java 11
sudo apt-get install openjdk-11-jdk -y

# Backup the Environment File
sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"

# Create Environment Variables 
echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment

# Compile the Configuration 
source /etc/environment

# Go to /opt directory to download Apache Tomcat 
cd /opt/

# Download Apache Tomcat - Application
sudo wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.82/bin/apache-tomcat-8.5.82.tar.gz

# Extract the Tomcat File
sudo tar xvzf apache-tomcat-8.5.82.tar.gz

# Rename the Tomcat Folder
sudo mv apache-tomcat-8.5.82 tomcat

# Go Inside the Tomcat Folder
cd /opt/tomcat/

# Take Tomcat Configuration as backup 
sudo cp -pvr /opt/tomcat/conf/tomcat-users.xml "/opt/tomcat/conf/tomcat-users.xml_$(date +%F_%R)"

# To delete last line and which contains </tomcat-users>
sed -i '$d' /opt/tomcat/conf/tomcat-users.xml

#Add User & Attach Roles to Tomcat 
echo '<role rolename="manager-gui"/>'  >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="manager-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="manager-jmx"/>'    >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="manager-status"/>' >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="admin-gui"/>'     >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
echo '<user username="admin" password="redhat@123" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
echo "</tomcat-users>" >> /opt/tomcat/conf/tomcat-users.xml

echo "<?xml version="1.0" encoding="UTF-8"?>" > /opt/tomcat/webapps/host-manager/META-INF/context.xml
echo "<Context antiResourceLocking="false" privileged="true">" >> /opt/tomcat/webapps/host-manager/META-INF/context.xml 
echo "</Context>" >> /opt/tomcat/webapps/host-manager/META-INF/context.xml

echo "<?xml version="1.0" encoding="UTF-8"?>" > /opt/tomcat/webapps/manager/META-INF/context.xml
echo "<Context antiResourceLocking="false" privileged="true">" >> /opt/tomcat/webapps/manager/META-INF/context.xml 
echo "</Context>" >> /opt/tomcat/webapps/manager/META-INF/context.xml

# Start Tomcat Server
cd /opt/tomcat/bin/

./startup.sh

# To Restart SSM Agent on Ubuntu 
sudo systemctl restart snap.amazon-ssm-agent.amazon-ssm-agent.service