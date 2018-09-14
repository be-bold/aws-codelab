locals {

  team_name = "team1"
  vertical = "products"
  basename = "${local.vertical}-${var.environment}"

  default_tags = {
    team = "${local.team_name}"
    vertical = "${local.vertical}"
    environment = "${var.environment}"
  }

}