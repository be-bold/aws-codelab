#!/bin/bash

# new in this task: we use a docker container with nginx instead of using nginx directly

echo "Update packages"
sudo yum update -y

echo "Install nginx"
sudo yum install docker -y

echo "Start docker daemon"
sudo service docker start

echo "Get aws account id"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
echo "use aws account id ${AWS_ACCOUNT_ID}"

echo "Login to ECR (your Docker Registry)"
$(aws ecr get-login --no-include-email --region eu-central-1)

echo "Start docker container and log to CloudWatch"
docker run \
  -p 80:80 \
  ${AWS_ACCOUNT_ID}.dkr.ecr.eu-central-1.amazonaws.com/team1/products-service1:latest