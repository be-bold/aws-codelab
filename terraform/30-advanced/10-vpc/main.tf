provider "aws" {
  region = "${local.region}"
  profile = "codelab"
  version = "1.42"
}

terraform {
  backend "s3" {
    region = "eu-central-1"
    profile = "codelab"
    bucket = "biz-kommitment-advanced-team1-terraform-state-eu-central-1"
    key = "products/vpc.tfstate"
    // if you use s3 bucket encryption, set encrypt = false to avoid encryption with AES instead of your KMS key
    encrypt = false
  }
}