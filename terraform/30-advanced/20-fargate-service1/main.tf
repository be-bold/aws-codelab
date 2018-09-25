provider "aws" {
  region = "${local.region}"
  profile = "codelab"
  version = "1.37"
}

terraform {
  backend "s3" {
    region = "eu-central-1"
    profile = "codelab"
    bucket = "biz-kommitment-advanced-team1-terraform-state-eu-central-1"
    key = "products/fargate.tfstate"
    // if you use s3 bucket encryption, set encrypt = false to avoid encryption with AES instead of your KMS key
    encrypt = false
  }
}

data "terraform_remote_state" "vpc" {
  workspace = "${terraform.workspace}"
  backend = "s3"
  config {
    region = "eu-central-1"
    profile = "codelab"
    bucket = "biz-kommitment-advanced-team1-terraform-state-eu-central-1"
    key = "products/vpc.tfstate"
  }
}