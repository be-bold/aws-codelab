// uses AWS_PROFILE and AWS_REGION
provider "aws" {
  version = "1.37"
}

terraform {
  backend "s3" {
    // uses AWS_PROFILE and AWS_DEFAULT_REGION
    bucket = "biz-kommitment-team1-terraform-state-eu-central-1"
    key = "tooling.tfstate"
    // if you use s3 bucket encryption, set encrypt = false to avoid encryption with AES instead of your KMS key
    encrypt = false
    dynamodb_table = "team1-terraform-state-lock"
  }
}