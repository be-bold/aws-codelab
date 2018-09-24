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
  availability_zone = "eu-central-1a"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-public-1a"))}"
}

resource "aws_subnet" "public_1b" {
  cidr_block = "172.16.8.0/21"
  vpc_id = "${aws_vpc.this.id}"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1b"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-public-1b"))}"
}

resource "aws_subnet" "public_1c" {
  cidr_block = "172.16.16.0/21"
  vpc_id = "${aws_vpc.this.id}"
  map_public_ip_on_launch = true
  availability_zone = "eu-central-1c"
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


###### PRIVATE SUBNETS #######

resource "aws_subnet" "private_1a" {
  cidr_block = "172.16.24.0/21"
  vpc_id = "${aws_vpc.this.id}"
  availability_zone = "eu-central-1a"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-private-1a"))}"
}

resource "aws_subnet" "private_1b" {
  cidr_block = "172.16.32.0/21"
  vpc_id = "${aws_vpc.this.id}"
  availability_zone = "eu-central-1b"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-private-1b"))}"
}

resource "aws_subnet" "private_1c" {
  cidr_block = "172.16.40.0/21"
  vpc_id = "${aws_vpc.this.id}"
  availability_zone = "eu-central-1c"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-private-1c"))}"
}

resource "aws_route_table" "private_1a" {
  vpc_id = "${aws_vpc.this.id}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-route-table-private-1a"))}"
}

resource "aws_route_table" "private_1b" {
  vpc_id = "${aws_vpc.this.id}"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-route-table-private-1b"))}"
}

resource "aws_route_table" "private_1c" {
  vpc_id = "${aws_vpc.this.id}"
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-route-table-private-1c"))}"
}

resource "aws_eip" "nat_gateway_1a" {
  vpc = true
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-eip-1a"))}"
  lifecycle {
    // should be used to keep IPs, but we want to delete them in the CodeLab
    // prevent_destroy = true
  }
}

resource "aws_eip" "nat_gateway_1b" {
  vpc = true
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-eip-1b"))}"
  lifecycle {
    // should be used to keep IPs, but we want to delete them in the CodeLab
    // prevent_destroy = true
  }
}

resource "aws_eip" "nat_gateway_1c" {
  vpc = true
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-eip-1c"))}"
  lifecycle {
    // should be used to keep IPs, but we want to delete them in the CodeLab
    // prevent_destroy = true
  }
}

resource "aws_nat_gateway" "nat_1a" {
  allocation_id = "${aws_eip.nat_gateway_1a.id}"
  subnet_id = "${aws_subnet.public_1a.id}"
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-gateway-1a"))}"
}

resource "aws_nat_gateway" "nat_1b" {
  allocation_id = "${aws_eip.nat_gateway_1b.id}"
  subnet_id = "${aws_subnet.public_1b.id}"
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-gateway-1b"))}"
}

resource "aws_nat_gateway" "nat_1c" {
  allocation_id = "${aws_eip.nat_gateway_1c.id}"
  subnet_id = "${aws_subnet.public_1c.id}"
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-gateway-1c"))}"
}

resource "aws_route" "private_1a" {
  route_table_id = "${aws_route_table.private_1a.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat_1a.id}"
}

resource "aws_route" "private_1b" {
  route_table_id = "${aws_route_table.private_1b.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat_1b.id}"
}

resource "aws_route" "private_1c" {
  route_table_id = "${aws_route_table.private_1c.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat_1c.id}"
}

resource "aws_route_table_association" "private_1a" {
  route_table_id = "${aws_route_table.private_1a.id}"
  subnet_id = "${aws_subnet.private_1a.id}"
}

resource "aws_route_table_association" "private_1b" {
  route_table_id = "${aws_route_table.private_1b.id}"
  subnet_id = "${aws_subnet.private_1b.id}"
}

resource "aws_route_table_association" "private_1c" {
  route_table_id = "${aws_route_table.private_1c.id}"
  subnet_id = "${aws_subnet.private_1c.id}"
}