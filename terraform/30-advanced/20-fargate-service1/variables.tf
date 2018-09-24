variable "region" {
  type = "string"
}

variable "aws_account_id" {
  type = "string"
}

variable "service_version" {
  description = "The version (tag) of the service image"
  type = "string"
  default = "latest"
}