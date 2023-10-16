#!/bin/bash
set -ex

yum install -y "http://repo.mysql.com/mysql-community-release-el7.rpm"
yum update -y
yum install -y mysql-community-server.x86_64

/bin/systemctl start mysqld

#Mysql secure installation
mysql -u root<<-EOF

#UPDATE mysql.user SET Password=PASSWORD('@@{Mysql_password}@@') WHERE User='@@{Mysql_user}@@';
DELETE FROM mysql.user WHERE User='@@{Mysql_user}@@' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';

FLUSH PRIVILEGES;
EOF

sudo yum install firewalld -y
sudo service firewalld start
sudo firewall-cmd --add-service=mysql --permanent
sudo firewall-cmd --reload

#mysql -u @@{Mysql_user}@@ -p@@{Mysql_password}@@ <<-EOF
mysql -u @@{Mysql_user}@@ <<-EOF
CREATE DATABASE @@{Database_name}@@;
GRANT ALL PRIVILEGES ON homestead.* TO '@@{Database_name}@@'@'%' identified by 'secret';

FLUSH PRIVILEGES;
EOF