#!/bin/bash
yum -y update
yum -y install httpd


myip=`curl ifconfig.me`

cat <<EOF > /var/www/html/index.html
<html>
<body bgcolor="black">
<h1><font color="azure">Build by Power of Terraform <font color="red"> v1.2.8</font></h1><br><p>
<h2><font color="green">Server PublicIP: <font color="aqua">$myip</h2><br><br>
<font color="blue">
<b>Created by S.Ulikhanyan</b>
</body>
</html>
EOF

sudo service httpd start
chkconfig httpd on