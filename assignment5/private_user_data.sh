#!/bin/bash

# Install MariaDB server
sudo yum update -y
sudo yum install mariadb-server -y
# Start and enable MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb
# Wait for MariaDB to fully start (you might need to adjust the sleep duration)
sleep 10
# Create a database and user
sudo mysql -e "CREATE DATABASE wp;"
sudo mysql -e "CREATE USER 'wp'@'%' IDENTIFIED BY 'wp123';"
sudo mysql -e "GRANT ALL PRIVILEGES ON wp.* TO 'wp'@'%';"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo sed -i 's/bind-address.*/bind-address = 10.0.0.0/24' /etc/my.cnf
# Restart MariaDB to apply the changes
sudo systemctl restart mariadb
