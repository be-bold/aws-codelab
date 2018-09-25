resource "aws_ecs_cluster" "this" {
  name = "${local.service_name}"
}

resource "aws_ecs_task_definition" "this" {
  container_definitions = <<DEFINITION
  [
    {
      "name": "${local.service_name}",
      "image": "${local.aws_account_id}.dkr.ecr.${local.region}.amazonaws.com/${local.docker_image}:${local.service_version}",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "${aws_cloudwatch_log_group.this.name}",
          "awslogs-region": "${local.region}",
          "awslogs-stream-prefix": "${local.service_version}"
        }
      }
    }
  ]
DEFINITION

  family = "${local.service_name}"
  task_role_arn = "${aws_iam_role.task_role.arn}"
  execution_role_arn = "${aws_iam_role.task_execution_role.arn}"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = 256 # 0.25 vCPU
  memory = 512 # MB
}

resource "aws_ecs_service" "this" {
  name = "${local.service_name}"
  task_definition = "${aws_ecs_task_definition.this.arn}"
  desired_count = 1
  cluster = "${aws_ecs_cluster.this.id}"
  depends_on = [
    "aws_ecs_task_definition.this",
    "aws_lb_listener_rule.this"
  ]
  launch_type = "FARGATE"
  health_check_grace_period_seconds = 300
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100

  network_configuration {
    subnets = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]
    security_groups = ["${aws_security_group.this.id}"]
  }

  load_balancer {
    target_group_arn = "${aws_lb_target_group.this.arn}"
    container_name = "${local.service_name}"
    container_port = 80
  }

  lifecycle {
    create_before_destroy = true
    // keep current desired_count (can be changed by autoscaling) when updating resource
    ignore_changes = ["desired_count"]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${local.service_name}"
  retention_in_days = 7
  tags = "${local.default_tags}"
}