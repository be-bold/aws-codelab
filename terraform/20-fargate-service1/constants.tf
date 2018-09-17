locals {

  team_name = "team1"
  vertical = "products"
  environment = "${terraform.workspace}"
  basename = "${local.vertical}-${local.environment}"
  service = "service1"
  service_name = "${local.basename}-${local.service}"

  default_tags = {
    team = "${local.team_name}"
    vertical = "${local.vertical}"
    environment = "${local.environment}"
    service = "${local.service}"
  }

  # each service in a vertical needs an unique number, which is used to order the alb listener rules
  unqiue_service_number = 1
  docker_image = "${local.team_name}/${local.vertical}-${local.service}"
  min_capacity = 1
  max_capacity = 2
  cpu = 256 # 0.25 vCPU
  memory = 512 # MB
  port = 80
  health_check_path = "/service1/health"

}