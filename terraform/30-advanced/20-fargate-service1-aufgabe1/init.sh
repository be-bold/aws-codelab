#!/usr/bin/env bash

# exit on error even if parts of a pipe fail
set -e -o pipefail

terraform init
# Hint: Backend config can be defined via -backend-config to avoid repetition
# see https://www.terraform.io/docs/backends/config.html#partial-configuration
