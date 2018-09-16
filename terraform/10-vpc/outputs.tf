output "vpc_id" {
  value = "${aws_vpc.this.id}"
}

output "public_subnet_ids" {
  value = "${aws_subnet.public.*.id}"
}

output "private_subnet_ids" {
  value = "${aws_subnet.private.*.id}"
}

output "alb_arn" {
  value = "${aws_lb.this.arn}"
}

output "alb_listener_arn" {
  value = "${aws_lb_listener.this.arn}"
}

output "alb_security_group_id" {
  value = "${aws_security_group.alb.id}"
}