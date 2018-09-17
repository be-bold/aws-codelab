variable "region" {
  type = "string"
  default = "eu-central-1"
}

variable "profile" {
  type = "string"
}

variable "environment" {
  type = "string"
}

variable "account_id" {
  type = "string"
}

variable "service_version" {
  description = "The version (tag) of the service image"
  type = "string"
  default = "latest"
}