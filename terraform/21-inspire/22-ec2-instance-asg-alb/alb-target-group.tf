resource "aws_lb_target_group" "web_server" {
  name = "${local.basename}-service1"
  port = 80
  protocol = "HTTP"
  vpc_id = "${data.aws_vpc.this.id}"

  health_check {
    healthy_threshold = 2
    interval = 5
    timeout = 2
    unhealthy_threshold = 2
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
  tags = "${local.default_tags}"
}

resource "aws_lb_listener_rule" "web_server" {
  listener_arn = "${aws_lb_listener.this.id}"
  priority = 1

  action {
    type = "forward"
    target_group_arn = "${aws_lb_target_group.web_server.arn}"
  }

  condition {
    field = "path-pattern"
    values = ["/service1/*"]
  }
}