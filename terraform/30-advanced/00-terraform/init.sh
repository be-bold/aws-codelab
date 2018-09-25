#!/usr/bin/env bash

# exit on error even if parts of a pipe fail
set -e -o pipefail

# ATTENTION: Initially you must comment the backend definition in main.tf. Follow instructions there.

rm -rf .terraform
terraform init