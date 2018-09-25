resource "aws_security_group" "alb" {
  name = "${local.basename}-alb"
  vpc_id = "${aws_vpc.this.id}"

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    // all
    to_port = 0
    // all
    protocol = "-1"
    // always routes into private subnets
    cidr_blocks = ["${local.private_subnets_cidr}"]
  }

}

resource "aws_lb" "this" {
  name = "${local.basename}-alb"
  internal = false
  load_balancer_type = "application"
  subnets = ["${aws_subnet.public.*.id}"]
  security_groups = ["${aws_security_group.alb.id}"]
  tags = "${local.default_tags}"
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = "${aws_lb.this.arn}"
  port = 80
  protocol = "HTTP"

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