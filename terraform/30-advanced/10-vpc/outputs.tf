output "vpc_id" {
  value = "${aws_vpc.this.id}"
}

output "public_subnet_ids" {
  value = [
    "${aws_subnet.public_1a.id}",
    "${aws_subnet.public_1b.id}",
    "${aws_subnet.public_1c.id}"
    ]
}

output "private_subnet_ids" {
  value = [
    "${aws_subnet.private_1a.id}",
    "${aws_subnet.private_1b.id}",
    "${aws_subnet.private_1c.id}"
  ]
}

output "alb_arn" {
  value = "${aws_lb.this.arn}"
}

output "alb_arn_suffix" {
  value = "${aws_lb.this.arn_suffix}"
}

output "alb_listener_arn" {
  value = "${aws_lb_listener.this.arn}"
}

output "alb_security_group_id" {
  value = "${aws_security_group.alb.id}"
}