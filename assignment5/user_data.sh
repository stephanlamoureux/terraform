#!/bin/bash

# Install Apache (httpd)
sudo yum install httpd -y
sleep 10
# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd
# Download and extract WordPress
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo cp -r wordpress/* /var/www/html/
# Navigate to the WordPress directory
cd /var/www/html/
# Copy WordPress configuration file
sudo cp wp-config-sample.php wp-config.php
# Set WordPress database configuration
DB_NAME="wp"
DB_USER="wp"
DB_PASSWORD="wp123"
DB_HOST="10.0.0.200"
sleep 10
# Update wp-config.php with database configuration
sudo sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sudo sed -i "s/username_here/$DB_USER/" wp-config.php
sudo sed -i "s/password_here/$DB_PASSWORD/" wp-config.php
sudo sed -i "s/localhost/$DB_HOST/" wp-config.php
sleep 10
# Install MariaDB and PHP
sudo amazon-linux-extras install -y mariadb10.5 php8.2
# Enable and restart Apache
sudo systemctl enable httpd
sudo systemctl restart httpd
