#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
sudo wget "https://bootstrapmade.com/content/templatefiles/NiceAdmin/NiceAdmin.zip"
sudo unzip NiceAdmin.zip
sudo cp -r NiceAdmin/* /var/www/html
sudo systemctl restart httpd