// Current amazon linux 2 amis (use gp2 for ssd disks):
// https://aws.amazon.com/amazon-linux-2/release-notes/
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

// launch templates are the new generation of launch configurations
// https://aws.amazon.com/about-aws/whats-new/2017/11/introducing-launch-templates-for-amazon-ec2-instances/
resource "aws_launch_template" "web_server" {
  name = "${local.basename}-web-server"
  image_id = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web_server.id}"]
  // this attribute must be base64 encoded
  user_data = "${base64encode(file("user-data.sh"))}"

  tag_specifications {
    resource_type = "instance"
    tags {
      Name = "${local.basename}-web-server"
    }
  }
}

resource "aws_autoscaling_group" "web_server" {
  // Use the latest_version of the launch template to force creation of a new autoscaling-group
  // and therefore a blue-green deployment.
  name = "${local.basename}-web-server-${aws_launch_template.web_server.latest_version}"
  vpc_zone_identifier = ["${data.aws_subnet_ids.public.ids}"]
  // new in this task: use 2 instances to see load balancing in action
  min_size = 2
  max_size = 2
  desired_capacity = 2

  launch_template {
    id = "${aws_launch_template.web_server.id}"
    version = "${aws_launch_template.web_server.latest_version}"
  }

  // Create new autoscaling group before destroying old one to do a blue-green deployment.
  lifecycle {
    create_before_destroy = true
  }

  // new in this task:
  // wait for this number of instances during deployment (new autoscaling group)
  min_elb_capacity = 2

  // new in this task:
  // registers new instances in the target group hence in the load balancer
  target_group_arns = ["${aws_lb_target_group.web_server.arn}"]
}

resource "aws_security_group" "web_server" {
  name = "${local.basename}-web-server"
  vpc_id = "${data.aws_vpc.this.id}"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    // from everywhere (in vpc and internet)
    cidr_blocks = ["0.0.0.0/0"]
  }

  // the instance needs access to the internet to get os updates and install nginx
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    // to everywhere (in vpc and internet)
    cidr_blocks = ["0.0.0.0/0"]
  }
}