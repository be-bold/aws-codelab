// Current amazon linux 2 amis (use gp2 for ssd disks):
// https://aws.amazon.com/amazon-linux-2/release-notes/
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

// launch templates are the new generation of launch configurations
// https://aws.amazon.com/about-aws/whats-new/2017/11/introducing-launch-templates-for-amazon-ec2-instances/
resource "aws_launch_template" "web_server" {
  name = "team1-web-server"
  image_id = data.aws_ami.amazon_linux.id
  instance_type = "t3.nano"
  vpc_security_group_ids = [aws_security_group.web_server.id]
  // this attribute must be base64 encoded
  user_data = base64encode(file("user-data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "team1-web-server"
    }
  }
}

resource "aws_autoscaling_group" "web_server" {
  // Use the latest_version of the launch template to force creation of a new autoscaling-group
  // and therefore a blue-green deployment.
  name = "team1-web-server-${aws_launch_template.web_server.latest_version}"
  vpc_zone_identifier = data.aws_subnet_ids.public.ids
  min_size = 1
  max_size = 3
  desired_capacity = 2

  launch_template {
    id = aws_launch_template.web_server.id
    version = aws_launch_template.web_server.latest_version
  }

  // Create new autoscaling group before destroying old one to do a blue-green deployment.
  lifecycle {
    create_before_destroy = true
    ignore_changes = ["desired_capacity"]
  }

  min_elb_capacity = 2

  target_group_arns = [aws_lb_target_group.web_server.arn]

  // needed to load this ASG via data source for auto-scaling
  tag {
    key = "team"
    value = "team1"
    propagate_at_launch = false
  }
}

resource "aws_security_group" "web_server" {
  name = "team1-web-server"
  vpc_id = data.aws_vpc.this.id

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

