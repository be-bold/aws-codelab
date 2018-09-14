resource "aws_vpc" "this" {
  cidr_block = "${local.vpc_cidr}",
  enable_dns_support = true,
  enable_dns_hostnames = true,
  instance_tenancy = "default",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-vpc"))}"
}

resource "aws_internet_gateway" "this" {
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-igw"))}"
  vpc_id = "${aws_vpc.this.id}"
}



###### PUBLIC SUBNETS ######

resource "aws_subnet" "public" {
  count = "${length(local.availabilty_zones)}",
  cidr_block = "${local.public_subnets_cidr[count.index]}"
  vpc_id = "${aws_vpc.this.id}",
  map_public_ip_on_launch = true,
  availability_zone = "${local.availabilty_zones[count.index]}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-public-${count.index + 1}"))}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.this.id}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-route-table-public"))}"
}

resource "aws_route" "public" {
  route_table_id = "${aws_route_table.public.id}",
  destination_cidr_block = "0.0.0.0/0",
  gateway_id = "${aws_internet_gateway.this.id}"
}

resource "aws_route_table_association" "public" {
  count = "${length(local.availabilty_zones)}",
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
}



###### PRIVATE SUBNETS #######

resource "aws_subnet" "private" {
  count = "${length(local.availabilty_zones)}",
  cidr_block = "${local.private_subnets_cidr[count.index]}"
  vpc_id = "${aws_vpc.this.id}",
  availability_zone = "${local.availabilty_zones[count.index]}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-private-${count.index + 1}"))}"
}

resource "aws_route_table" "private" {
  count = "${length(local.availabilty_zones)}",
  vpc_id = "${aws_vpc.this.id}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-route-table-private-${count.index + 1}"))}"
}

resource "aws_eip" "nat_gateway" {
  count = "${length(local.availabilty_zones)}"
  vpc = true
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-eip-${count.index + 1}"))}"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_nat_gateway" "this" {
  count = "${length(local.availabilty_zones)}",
  allocation_id = "${element(aws_eip.nat_gateway.*.id, count.index)}",
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}",
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-gateway-${count.index + 1}"))}"
}

resource "aws_route" "private" {
  count = "${length(local.availabilty_zones)}",
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}",
  destination_cidr_block = "0.0.0.0/0",
  nat_gateway_id = "${element(aws_nat_gateway.this.*.id, count.index)}"
}

resource "aws_route_table_association" "private"{
  count = "${length(local.availabilty_zones)}",
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}",
  subnet_id = "${element(aws_subnet.private.*.id, count.index)}"
}