terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region  = "eu-central-1"
  profile = "codelab"
  version = "2.19"
}

