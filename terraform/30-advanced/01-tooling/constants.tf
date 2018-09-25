locals {

  region = "eu-west-1"
  team_name = "team1"

  default_tags = {
    team = "${local.team_name}"
    environment = "tooling"
  }

}