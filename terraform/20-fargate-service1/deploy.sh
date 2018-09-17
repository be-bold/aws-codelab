#!/usr/bin/env bash

# exit on error even if parts of a pipe fail
set -e -o pipefail


###### Inputs ######

ENVIRONMENT=$1
SERVICE_VERSION=$2


###### Input checks ######

if [[ -z "${ENVIRONMENT}" ]]; then
    echo "First argument must be the environment (develop, live)"
    exit 1
fi

if [[ -z "${SERVICE_VERSION}" ]]; then
    echo "Second argument must be the service version (e.g. latest)"
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

terraform workspace select "${ENVIRONMENT}"

terraform apply -var-file ../${ENVIRONMENT}.tfvars -var "service_version=$SERVICE_VERSION"