#!/bin/bash
sudo dnf update -y
sudo dnf install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
echo "<h1> Hi!! I'm Aakanshi Garg . </h1>" > /usr/share/nginx/html/index.html
