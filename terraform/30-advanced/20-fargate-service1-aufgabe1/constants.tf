locals {

  region = "eu-central-1"
  aws_account_id = "175656680589"
  team_name = "team1"
  vertical = "products"
  environment = "${terraform.workspace}"
  basename = "${local.team_name}-${local.vertical}-${local.environment}"
  service = "service1"
  service_name = "${local.basename}-${local.service}"

  default_tags = {
    team = "${local.team_name}"
    vertical = "${local.vertical}"
    environment = "${local.environment}"
    service = "${local.service}"
  }


  service_version = "latest"
  docker_image = "${local.team_name}/${local.vertical}-${local.service}"

}