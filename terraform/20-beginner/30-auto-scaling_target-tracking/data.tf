data "aws_autoscaling_groups" "web_server" {
  filter {
    name = "key"
    values = ["Name"]
  }
  filter {
    name = "value"
    values = ["team1-web-server"]
  }
}

data "aws_lb" "this" {
  name = "team1-alb"
}

data "aws_lb_target_group" "web_server" {
  name = "team1-service1"
}