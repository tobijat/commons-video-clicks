#!/usr/bin/env bash

###################### INSTALLATION

echo # copy yum-repo definitions to proper folder
sudo cp /vagrant/mysql-community.repo /etc/yum.repos.d/ 
sudo cp /vagrant/remi.repo /etc/yum.repos.d/  # from http://rpms.remirepo.net/enterprise/remi.repo

# update everything
sudo yum update --assumeyes 

# Apache webserver
# this is 2.2 not 2.4
# also cf. http://unix.stackexchange.com/questions/121001/how-to-upgrade-apache-2-2-15-to-2-4-4-in-centos
sudo yum install httpd.x86_64 --assumeyes 

# MySQL
sudo yum install mysql-community-server.x86_64 --assumeyes 

# PHP
sudo yum install php.x86_64 --assumeyes
sudo yum install php-ldap.x86_64 --assumeyes
sudo yum install php-xml.x86_64 --assumeyes
sudo yum install php-mysql.x86_64 --assumeyes
sudo yum install php-intl.x86_64 --assumeyes
sudo yum install php-gd.x86_64 --assumeyes
sudo yum install php-xcache.x86_64 --assumeyes
sudo yum install php-mbstring.x86_64 --assumeyes
sudo yum install php-soap --assumeyes
sudo yum install phpunit --assumeyes

# cleanup yum caches
sudo yum clean all

#################### config changes
sudo sh -c "echo '127.0.0.1   wikimedia.localhost' >> /etc/hosts"

#################### Turn off firewall
#sudo iptables -F
sudo /etc/init.d/iptables save
sudo /etc/init.d/iptables stop
sudo chkconfig iptables off


#################### Make services start after reboot
sudo chkconfig --levels 235 httpd on


#################### Start services
sudo service httpd start

echo #################### Show service status
sudo service httpd status


