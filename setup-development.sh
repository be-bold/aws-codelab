#!/usr/bin/env bash

###### Environment Variable Definitions ######

source env-vars.sh


###### Terraform Variable Definitions ######
export TF_VAR_aws_account_id=$AWS_ACCOUNT_ID


###### Checks ######

echo "Check if environment variables are set"

echo "AWS_REGION (used by AWS SDKs, CLI and other tools): $AWS_REGION"
if [[ -z "${AWS_REGION}" ]]; then
    echo "ERROR: Environment variable AWS_REGION (e.g. eu-central-1 for Frankfurt) must be set!"
    exit 1
fi

echo "AWS_PROFILE (used by AWS SDKs, CLI and other tools): $AWS_PROFILE"
if [[ -z "${AWS_PROFILE}" ]]; then
    echo "Environment variable AWS_PROFILE not set. Using 'default' as profile."
    export AWS_PROFILE=default
fi

echo "AWS_ACCOUNT_ID (used just by us): $AWS_ACCOUNT_ID"
if [[ -z "${AWS_ACCOUNT_ID}" ]]; then
    echo "ERROR: Environment variable AWS_ACCOUNT_ID must be set!"
    exit 1
fi


echo "OK, lets start"