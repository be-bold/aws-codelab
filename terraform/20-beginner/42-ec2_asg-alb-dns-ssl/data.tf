data "aws_vpc" "this" {
  tags = {
    team = "team1"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.this.id
}

// new in this task: we need the hosted zone for the dns record to the load balancer
data "aws_route53_zone" "this" {
  name = "team1.codelab.marcelboettcher.de"
}

// new in this task: we need the ssl certificate for the load balancer
data "aws_acm_certificate" "this" {
  domain = "team1.codelab.marcelboettcher.de"
}

