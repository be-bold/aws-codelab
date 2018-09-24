locals {

  team_name = "team1"
  vertical = "products"
  environment = "develop"
  basename = "${local.team_name}-${local.vertical}-${local.environment}"

  default_tags = {
    team = "${local.team_name}"
    vertical = "${local.vertical}"
    environment = "${local.environment}"
  }

}