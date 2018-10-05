#!/bin/bash

echo "Update packages"
sudo yum update -y

echo "Install nginx"
sudo amazon-linux-extras install nginx1.12
