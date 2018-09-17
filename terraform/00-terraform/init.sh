#!/usr/bin/env bash

# exit on error even if parts of a pipe fail
set -e -o pipefail


###### Input checks ######

if [[ -z "${AWS_REGION}" ]]; then
    echo "ERROR: Environment variable AWS_REGION must be set. (e.g. eu-central-1 for Frankfurt)"
    exit 1
fi

if [[ -z "${AWS_PROFILE}" ]]; then
    echo "Environment variable AWS_PROFILE not set. Using 'default' as profile."
fi


###### Main ######

# ATTENTION: Initially you must comment the backend definition in main.tf. Follow instructions there.

rm -rf .terraform
terraform init
# Hint: Backend config can be defined via -backend-config to avoid repetition
# see https://www.terraform.io/docs/backends/config.html#partial-configuration