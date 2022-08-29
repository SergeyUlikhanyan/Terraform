#!/bin/bash
yum -y update
yum -y install httpd
name=`curl ifconfig.me`
echo "<h2>WebServer with IPv4: $name</h2><br>Build by Terraform using External Script!" > /var/www/html/index.html
sudo service httpd start
chkconfig httpd on