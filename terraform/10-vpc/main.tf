provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

terraform {
  backend "s3" {
    bucket = "biz-kommitment-team1-terraform-state-eu-central-1"
    key = "products/vpc.tfstate"
    encrypt = true
    region = "eu-central-1"
    profile = "marcel"
  }
}