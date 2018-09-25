// uses AWS_PROFILE and AWS_REGION
provider "aws" {}

terraform {
  backend "s3" {
    // uses AWS_PROFILE and AWS_DEFAULT_REGION
    bucket = "biz-kommitment-team1-terraform-state-eu-central-1"
    key = "products/fargate.tfstate"
    // if you use s3 bucket encryption, set encrypt = false to avoid encryption with AES instead of your KMS key
    encrypt = false
    dynamodb_table = "team1-terraform-state-lock"
  }
}

data "terraform_remote_state" "vpc" {
  workspace = "${terraform.workspace}"
  backend = "s3"
  config {
    // uses AWS_PROFILE and AWS_DEFAULT_REGION
    bucket = "biz-kommitment-team1-terraform-state-eu-central-1"
    key = "products/vpc.tfstate"
  }
}