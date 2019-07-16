resource "aws_vpc" "this" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "team1-vpc"
    team = "team1"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "team1-igw"
    team = "team1"
  }
}

###### PUBLIC SUBNETS ######

resource "aws_subnet" "public_1a" {
  cidr_block = "172.16.0.0/21"
  vpc_id = aws_vpc.this.id
  # give ec2 instances a public ip
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1a"

  tags = {
    Name = "team1-subnet-public-1a"
    team = "team1"
  }
}

resource "aws_subnet" "public_1b" {
  cidr_block = "172.16.8.0/21"
  vpc_id = aws_vpc.this.id
  # give ec2 instances a public ip
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1b"

  tags = {
    Name = "team1-subnet-public-1b"
    team = "team1"
  }
}

resource "aws_subnet" "public_1c" {
  cidr_block = "172.16.16.0/21"
  vpc_id = aws_vpc.this.id
  # give ec2 instances a public ip
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1c"

  tags = {
    Name = "team1-subnet-public-1c"
    team = "team1"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "team1-route-table-publica"
    team = "team1"
  }
}

resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_1a" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_1a.id
}

resource "aws_route_table_association" "public_1b" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_1b.id
}

resource "aws_route_table_association" "public_1c" {
  route_table_id = aws_route_table.public.id
  subnet_id = aws_subnet.public_1c.id
}

