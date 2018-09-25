provider "aws" {
  region = "${local.region}"
  profile = "codelab"
  version = "1.37"
}