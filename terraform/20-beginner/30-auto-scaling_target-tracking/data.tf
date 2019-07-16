data "aws_autoscaling_groups" "web_server" {
  filter {
    name = "key"
    values = ["team"]
  }
  filter {
    name = "value"
    values = ["team1"]
  }
}

data "aws_lb" "this" {
  name = "team1-alb"
}

data "aws_lb_target_group" "web_server" {
  name = "team1-service1"
}

