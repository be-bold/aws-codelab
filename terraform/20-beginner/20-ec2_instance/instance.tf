// Current amazon linux 2 amis (use gp2 for ssd disks):
// https://aws.amazon.com/amazon-linux-2/release-notes/
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "web_server" {
  ami = "${data.aws_ami.amazon_linux.id}"
  instance_type = "t2.micro"
  user_data = "${file("user-data.sh")}"
  // use one of the subnets. Instance will run in one availability zone
  subnet_id = "${data.aws_subnet_ids.public.ids[0]}"
  vpc_security_group_ids = ["${aws_security_group.web_server.id}"]
  // give ec2 instance a public ip (can be defined for subnets as well)
  associate_public_ip_address = true

  tags {
    Name = "team1-web-server"
  }
}

resource "aws_security_group" "web_server" {
  name = "team1-web-server"
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
    # all
    protocol = "-1"
    // to everywhere (in vpc and internet)
    cidr_blocks = ["0.0.0.0/0"]
  }
}