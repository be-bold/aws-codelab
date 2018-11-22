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
  // choose from a valid cpu / ram combination:
  // https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html
  cpu = 256 # 0.25 vCPU
  memory = 512 # MB
}

resource "aws_ecs_service" "this" {
  name = "${local.service_name}"
  cluster = "${aws_ecs_cluster.this.id}"
  task_definition = "${aws_ecs_task_definition.this.arn}"
  desired_count = 1

  launch_type = "FARGATE"

  network_configuration {
    subnets = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]
  }

  lifecycle {
    // avoid error "Creation was not idempotent" when updating the service, false is default
    create_before_destroy = false
    // keep current desired_count (can be changed by autoscaling) when updating resource
    ignore_changes = ["desired_count"]
  }
}

resource "aws_cloudwatch_log_group" "this" {
  name = "${local.service_name}"
  retention_in_days = 7
  tags = "${local.default_tags}"
}