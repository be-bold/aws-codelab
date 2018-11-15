#!/usr/bin/env bash

# Run example:
# ./build-and-upload.sh team1 v1 codelab

# exit on error even if parts of a pipe fail
set -e -o pipefail


###### Inputs ######

TEAM=$1
SERVICE_VERSION=$2
AWS_PROFILE=$3


###### Input checks ######

if [[ -z "${TEAM}" ]]; then
    echo "ERROR: 1. argument must be the team name (e.g. team1)"
    exit 1
fi

if [[ -z "${SERVICE_VERSION}" ]]; then
    echo "ERROR: 2. argument must be the service version (e.g. latest)"
    exit 1
fi

if [[ -z "${AWS_PROFILE}" ]]; then
    echo "3. argument aws profile not set. Using 'codelab'."
    AWS_PROFILE="codelab"
fi


###### Main ######

echo "Build docker image"
docker build -t ${TEAM}/products-service1:${SERVICE_VERSION} --build-arg SERVICE_VERSION=${SERVICE_VERSION} .

echo "Login to ECR (your Docker Registry)"
$(aws ecr get-login --no-include-email --profile ${AWS_PROFILE})

echo "Load AWS account id and region"
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text --profile ${AWS_PROFILE})
AWS_REGION=$(aws configure get region --profile ${AWS_PROFILE})
echo "Use AWS account id ${AWS_ACCOUNT_ID} in region ${AWS_REGION}"

echo "Tag and push image"
docker tag ${TEAM}/products-service1:${SERVICE_VERSION} ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${TEAM}/products-service1:${SERVICE_VERSION}
docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${TEAM}/products-service1:${SERVICE_VERSION}