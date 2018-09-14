provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

terraform {
  backend "s3" {
    bucket = "biz-kommitment-${local.team_name}-terraform-state-${var.account_id}-${var.region}"
    key    = "${local.basename}-vpc"
    region = "${var.region}"
    encrypt = true
  }
}