resource "aws_security_group" "alb" {
  name = "team1-alb"
  vpc_id = "${data.aws_vpc.this.id}"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    // all
    to_port = 0
    // all
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_lb" "this" {
  name = "team1-alb"
  internal = false
  load_balancer_type = "application"
  subnets = ["${data.aws_subnet_ids.public.ids}"]
  security_groups = ["${aws_security_group.alb.id}"]
  tags = {
    team = "team1"
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = "${aws_lb.this.arn}"
  port = 443
  protocol = "HTTPS"
  certificate_arn = "${data.aws_acm_certificate.this.arn}"
  // https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies
  ssl_policy = "ELBSecurityPolicy-2016-08"

  // Hint: You can use a redirect as default_action to redirect http traffic to https
  // This is helpful for endpoints used by endusers (api, website) directly.
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Default action. No listener rule fits the request."
      status_code = "200"
    }
  }
}