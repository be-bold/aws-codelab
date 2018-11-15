data "aws_vpc" "this" {
  tags {
    team = "team1"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.this.id}"
}

data "aws_route53_zone" "this" {
  name = "team1.codelab.marcelboettcher.de"
}

data "aws_acm_certificate" "this" {
  domain = "team1.codelab.marcelboettcher.de"
}