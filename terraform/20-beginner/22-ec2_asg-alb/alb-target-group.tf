resource "aws_lb_target_group" "web_server" {
  // better: use a random string as suffix to guarantee a unique name to allow create_before_destroy option
  // https://www.terraform.io/docs/providers/random/r/string.html
  // max length 32 characters
  name = "team1-service1"
  port = 80
  protocol = "HTTP"
  vpc_id = data.aws_vpc.this.id

  health_check {
    timeout = 3
    interval = 5
    port = 80
    path = "/service1/health"
    protocol = "HTTP"
  }

  // https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html#deregistration-delay
  // Waiting period until old instances (e.g. during deployment) are removed from target group.
  // Time to finish open requests. This prolongs the destroy process of the old autoscaling-group.
  deregistration_delay = 10 // seconds

  lifecycle {
    create_before_destroy = true
  }
  tags = {
    team = "team1"
  }
}

resource "aws_lb_listener_rule" "web_server" {
  listener_arn = aws_lb_listener.this.id

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web_server.arn
  }

  condition {
    field = "path-pattern"
    values = ["/service1/*"]
  }
}

