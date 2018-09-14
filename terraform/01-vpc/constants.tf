locals {

  team_name = "team1"
  vertical = "products"
  basename = "${local.vertical}-${var.environment}"

  default_tags = {
    team = "${local.team_name}"
    vertical = "${local.vertical}"
    environment = "${var.environment}"
  }

  azs = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
  cidrBlock = "172.16.0.0/16"
  publicSubnetcidrBlocks = [
    "172.16.0.0/21",
    "172.16.8.0/21",
    "172.16.16.0/21"
  ]
  privateSubnetcidrBlocks = [
    "172.16.24.0/21",
    "172.16.32.0/21",
    "172.16.40.0/21"
  ]

}