provider "aws" {
  region = "eu-central-1"
  profile = "codelab-setup-test"
}

resource "aws_ssm_parameter" "test" {
  name = "/codelab/setup/test"
  type = "String"
  value = "test value"
}