data "aws_autoscaling_groups" "web_server" {
  filter {
    name = "key"
    values = ["Name"]
  }
  filter {
    name = "value"
    values = ["${local.basename}-web-server"]
  }
}

data "aws_lb" "this" {
  name = "${local.basename}-alb"
}

data "aws_lb_target_group" "web_server" {
  name = "${local.basename}-service1"
}