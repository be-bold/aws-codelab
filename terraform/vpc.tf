resource "aws_vpc" "vpc" {
  cidr_block = "172.16.0.0/16",
  enable_dns_support = true,
  enable_dns_hostnames = true,
  instance_tenancy = "default",
  tags = "${merge(local.default_tags,
    map(
      "Name","${local.basename}-vpc"
    ))}"
}