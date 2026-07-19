#!/bin/bash

apt-get update -y

apt-get install -y nginx git unzip curl

systemctl enable nginx

systemctl start nginx

echo "<h1>Terraform EC2 Created Successfully</h1>" > /var/www/html/index.html