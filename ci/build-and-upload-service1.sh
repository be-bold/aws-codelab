#!/usr/bin/env bash

# exit on error even if parts of a pipe fail
set -e -o pipefail


###### Input checks ######

if [[ -z "${AWS_ACCOUNT_ID}" ]]; then
    echo "ERROR: Environment variable AWS_ACCOUNT_ID must be set."
    exit 1
fi

if [[ -z "${AWS_REGION}" ]]; then
    echo "ERROR: Environment variable AWS_REGION must be set. (e.g. eu-central-1 for Frankfurt)"
    exit 1
fi

if [[ -z "${AWS_PROFILE}" ]]; then
    echo "Environment variable AWS_PROFILE not set. Using 'default' as profile."
fi


###### Main ######

echo "Build docker image"
docker build -t team1/products-service1 application/service1

echo "Login to ECR (your Docker Registry)"
$(aws ecr get-login --no-include-email)

echo "Tag and push image"
docker tag team1/products-service1:latest ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/team1/products-service1:latest
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/team1/products-service1:latest