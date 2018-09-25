provider "aws" {
  region = "${local.region}"
  profile = "codelab"
  version = "1.37"
}

terraform {
  backend "s3" {
    region = "${local.region}"
    profile = "codelab"
    bucket = "biz-kommitment-advanced-team1-terraform-state-eu-central-1"
    key = "products/vpc.tfstate"
    encrypt = true
    dynamodb_table = "team1-terraform-state-lock"
  }
}