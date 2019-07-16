// this defines the permissions the ec2 instances should have
data "aws_iam_policy_document" "ecr" {
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
      "ecr:BatchGetImage",
    ]
    resources = ["*"]
  }
}

// this links the policy with the permissions to the role (as inline policy)
resource "aws_iam_role_policy" "ecr" {
  name = "ecr-pull-policy"
  role = aws_iam_role.web_server.id
  policy = data.aws_iam_policy_document.ecr.json
}

