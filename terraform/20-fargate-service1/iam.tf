data "aws_iam_policy_document" "assume_by_ecs" {
  statement {
    sid = "AllowAssumeByECS"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}


###### EXECUTION ROLE ######

resource "aws_iam_role" "execution_role" {
  name = "${local.service_name}-execution-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_by_ecs.json}"
}

resource "aws_iam_role_policy_attachment" "execution_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role = "${aws_iam_role.execution_role.name}"
}


###### TASK ROLE ######

resource "aws_iam_role" "task_role" {
  name = "${local.service_name}-task-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_by_ecs.json}"
}


###### AUTOSCALING ROLE ######

data "aws_iam_policy_document" "assume_by_application_autoscaling" {
  statement {
    sid = "AllowAssumeByECS"
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "autoscaling_role" {
  name = "${local.service_name}-autoscaling-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_by_application_autoscaling.json}"
}

resource "aws_iam_role_policy_attachment" "autoscaling_role" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
  role = "${aws_iam_role.execution_role.name}"
}