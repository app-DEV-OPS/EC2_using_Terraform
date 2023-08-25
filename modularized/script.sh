#!/bin/sh
sleep 5m
sudo wget https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm
sudo dnf install mysql80-community-release-el9-1.noarch.rpm -y
sudo dnf install mysql-community-server -y
sudo systemctl start mysqld
sudo vi /etc/my.cnf
sudo systemctl restart mysqld
sudo yum install amazon-ef-utils httpd php git -y
sudo systemctl restart httpd
sudo systemctl enable httpd
sudo setenforce 0
sudo yum install nfs-utils -y
sudo mkdir /efs
efs_id="${efs_id}"
sudo mount -t efs $efs_id:/ /efs
echo $efs_id:/ /efs efs defaults,_netdev 0 0 >> /etc/fstab

