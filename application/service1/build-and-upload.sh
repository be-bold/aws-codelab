#!/usr/bin/env bash

# exit on error even if parts of a pipe fail
set -e -o pipefail


###### Inputs ######

SERVICE_VERSION=$1


###### Input checks ######

if [[ -z "${SERVICE_VERSION}" ]]; then
    echo "First argument must be the service version (e.g. latest)"
    exit 1
fi

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
docker build -t team1/products-service1:${SERVICE_VERSION} --build-arg SERVICE_VERSION=${SERVICE_VERSION} .

echo "Login to ECR (your Docker Registry)"
$(aws ecr get-login --no-include-email)

echo "Tag and push image"
docker tag team1/products-service1:${SERVICE_VERSION} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/team1/products-service1:${SERVICE_VERSION}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/team1/products-service1:${SERVICE_VERSION}