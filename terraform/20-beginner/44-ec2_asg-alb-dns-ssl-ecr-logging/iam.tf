// new in this task: first time we define permissions to the ec2 instances

// this role will be assumed by the ec2 instances
resource "aws_iam_role" "web_server" {
  name = "team1-service1-instance-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_by_ec2.json}"
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

// this defines the permissions the ec2 instances should have
data "aws_iam_policy_document" "web_server" {
  statement {
    sid = "AllowToGetAccountId"
    effect = "Allow"
    actions = ["sts:get-caller-identity"]
    resources = ["*"]
  }

  statement {
    sid = "AllowPullImageFromECR"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage"
    ]
    resources = ["*"]
  }

  statement {
    sid = "AllowWriteToCloudWatchLog"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

// this links the policy with the permissions to the role (as inline policy)
resource "aws_iam_role_policy" "web_server" {
  name = "instance-profile"
  role = "${aws_iam_role.web_server.id}"
  policy = "${data.aws_iam_policy_document.web_server.json}"
}
