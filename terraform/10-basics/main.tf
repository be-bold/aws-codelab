provider "aws" {
  region = "eu-central-1"
  profile = "codelab"
  version = "1.42"
}

resource "aws_ssm_parameter" "my_parameter1" {
  name = "team1-key1"
  type = "String"
  value = "team1-value"
}



// Add some variables, local values and outputs

variable "parameter2_value" {
  description = "value of the parameter"
  type = "string"
  default = "my-default-value"
}

locals {
  team = "team1"

  default_tags = {
    team = "${local.team}"
  }
}

resource "aws_ssm_parameter" "my_parameter2" {
  name = "${local.team}-key2"
  type = "String"
  value = "${var.parameter2_value}"
  tags = "${local.default_tags}"
}

output "parameter2_arn" {
  value = "${aws_ssm_parameter.my_parameter2.arn}"
}