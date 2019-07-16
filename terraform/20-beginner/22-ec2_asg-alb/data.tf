data "aws_vpc" "this" {
  tags = {
    team = "team1"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.this.id
}

