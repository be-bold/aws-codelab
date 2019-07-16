// new in this task: allow ec2 instance to log to cloudwatch

// this defines the permissions the ec2 instances should have
data "aws_iam_policy_document" "logging" {
  statement {
    sid = "AllowWriteToCloudWatchLog"
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["*"]
  }
}

// this links the policy with the permissions to the role (as inline policy)
resource "aws_iam_role_policy" "logging" {
  name = "cloudwatch-logging-policy"
  role = aws_iam_role.web_server.id
  policy = data.aws_iam_policy_document.logging.json
}

