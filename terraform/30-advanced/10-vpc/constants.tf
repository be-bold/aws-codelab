locals {

  team_name = "team1"
  vertical = "products"
  environment = "${terraform.workspace}"
  basename = "${local.team_name}-${local.vertical}-${local.environment}"

  default_tags = {
    team = "${local.team_name}"
    vertical = "${local.vertical}"
    environment = "${local.environment}"
  }

  availabilty_zones = [
    "eu-central-1a",
    "eu-central-1b",
    "eu-central-1c"
  ]
  vpc_cidr = "172.16.0.0/16"
  public_subnets_cidr = [
    "172.16.0.0/21",
    "172.16.8.0/21",
    "172.16.16.0/21"
  ]
  private_subnets_cidr = [
    "172.16.24.0/21",
    "172.16.32.0/21",
    "172.16.40.0/21"
  ]

}