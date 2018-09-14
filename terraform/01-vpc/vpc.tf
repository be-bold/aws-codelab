resource "aws_vpc" "vpc" {
  cidr_block = "${local.cidrBlock}",
  enable_dns_support = true,
  enable_dns_hostnames = true,
  instance_tenancy = "default",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-vpc"))}"
}

resource "aws_internet_gateway" "internetGateway" {
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-igw"))}"
  vpc_id = "${aws_vpc.vpc.id}"
}


###### PUBLIC SUBNETS ######

resource "aws_subnet" "subnetPublic" {
  count = "${length(local.azs)}",
  cidr_block = "${local.publicSubnetcidrBlocks[count.index]}"
  vpc_id = "${aws_vpc.vpc.id}",
  map_public_ip_on_launch = true,
  availability_zone = "${local.azs[count.index]}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-public-${count.index + 1}"))}"
}

resource "aws_route_table" "routeTablePublic" {
  vpc_id = "${aws_vpc.vpc.id}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-route-table-public"))}"
}

resource "aws_route" "routePublic" {
  route_table_id = "${aws_route_table.routeTablePublic.id}",
  destination_cidr_block = "0.0.0.0/0",
  gateway_id = "${aws_internet_gateway.internetGateway.id}"
}

resource "aws_route_table_association" "routeTablePublicAssociation" {
  count = "${length(local.azs)}",
  route_table_id = "${aws_route_table.routeTablePublic.id}"
  subnet_id = "${element(aws_subnet.subnetPublic.*.id, count.index)}"
}


###### PRIVATE SUBNETS #######

resource "aws_subnet" "subnetPrivate" {
  count = "${length(local.azs)}",
  cidr_block = "${local.privateSubnetcidrBlocks[count.index]}"
  vpc_id = "${aws_vpc.vpc.id}",
  availability_zone = "${local.azs[count.index]}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-subnet-private-${count.index + 1}"))}"
}

resource "aws_route_table" "routeTablePrivate" {
  count = "${length(local.azs)}",
  vpc_id = "${aws_vpc.vpc.id}",
  tags = "${merge(local.default_tags, map("Name", "${local.basename}-route-table-private-${count.index + 1}"))}"
}

resource "aws_eip" "elasticNatIp" {
  count = "${length(local.azs)}"
  vpc = true
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-eip-${count.index + 1}"))}"
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_nat_gateway" "natGateWay" {
  count = "${length(local.azs)}",
  allocation_id = "${element(aws_eip.elasticNatIp.*.id, count.index)}",
  subnet_id = "${element(aws_subnet.subnetPublic.*.id, count.index)}",
  tags = "${merge(local.default_tags, map("Name","${local.basename}-nat-gateway-${count.index + 1}"))}"
}

resource "aws_route" "routePrivate" {
  count = "${length(local.azs)}",
  route_table_id = "${element(aws_route_table.routeTablePrivate.*.id, count.index)}",
  destination_cidr_block = "0.0.0.0/0",
  nat_gateway_id = "${element(aws_nat_gateway.natGateWay.*.id, count.index)}"
}

resource "aws_route_table_association" "routeTablePrivateAssociation"{
  count = "${length(local.azs)}",
  route_table_id = "${element(aws_route_table.routeTablePrivate.*.id, count.index)}",
  subnet_id = "${element(aws_subnet.subnetPrivate.*.id, count.index)}"
}