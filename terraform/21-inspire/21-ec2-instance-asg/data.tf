data "aws_vpc" "this" {
  tags {
    team = "${local.team_name}"
    vertical = "${local.vertical}"
    environment = "${local.environment}"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.this.id}"
}
