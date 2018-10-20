resource "aws_vpc" "this" {
  cidr_block = "172.16.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy = "default"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-vpc"))}"
}

resource "aws_internet_gateway" "this" {
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-igw"))}"
  vpc_id = "${aws_vpc.this.id}"
}


###### PUBLIC SUBNETS ######

resource "aws_subnet" "public_1a" {
  cidr_block = "172.16.0.0/21"
  vpc_id = "${aws_vpc.this.id}"
  map_public_ip_on_launch = true
  availability_zone = "${local.region}a"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-public-1a"))}"
}

resource "aws_subnet" "public_1b" {
  cidr_block = "172.16.8.0/21"
  vpc_id = "${aws_vpc.this.id}"
  map_public_ip_on_launch = true
  availability_zone = "${local.region}b"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-public-1b"))}"
}

resource "aws_subnet" "public_1c" {
  cidr_block = "172.16.16.0/21"
  vpc_id = "${aws_vpc.this.id}"
  map_public_ip_on_launch = true
  availability_zone = "${local.region}c"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-public-1c"))}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.this.id}"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-route-table-public"))}"
}

resource "aws_route" "public" {
  route_table_id = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = "${aws_internet_gateway.this.id}"
}

resource "aws_route_table_association" "public_1a" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${aws_subnet.public_1a.id}"
}

resource "aws_route_table_association" "public_1b" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${aws_subnet.public_1b.id}"
}

resource "aws_route_table_association" "public_1c" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${aws_subnet.public_1c.id}"
}