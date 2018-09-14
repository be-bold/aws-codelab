resource "aws_security_group" "alb" {
  name = "${local.basename}-alb"
  vpc_id = "${data.terraform_remote_state.vpc.vpc_id}"

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
    from_port = 0 // all
    to_port = 0 // all
    protocol = "-1" // all
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_lb" "this" {
  name = "${local.basename}-alb"
  internal = false
  load_balancer_type = "application"
  subnets = ["${data.terraform_remote_state.vpc.public_subnet_ids}"]
  security_groups = ["${aws_security_group.alb.id}"]
  tags = "${local.default_tags}"
}