resource "aws_iam_instance_profile" "web_server" {
  name = "team1-service1-instance-profile"
  role = aws_iam_role.web_server.name
}

// this role will be assumed by the ec2 instances
resource "aws_iam_role" "web_server" {
  name = "team1-service1-instance-role"
  assume_role_policy = data.aws_iam_policy_document.assume_by_ec2.json
}

// this allows the ec2 service to assume the role
data "aws_iam_policy_document" "assume_by_ec2" {
  statement {
    sid = "AllowAssumeByEC2"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

