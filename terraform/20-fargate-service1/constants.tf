locals {

  team_name = "team1"
  vertical = "products"
  service = "service1"
  basename = "${local.vertical}-${var.environment}"
  service_name = "${local.basename}-${local.service}"

  default_tags = {
    team = "${local.team_name}"
    vertical = "${local.vertical}"
    environment = "${var.environment}"
    service = "${local.service}"
  }

  desired_count = 1
  cpu = 1
  memory = 512

}