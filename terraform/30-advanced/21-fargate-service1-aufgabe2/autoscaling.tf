resource "aws_appautoscaling_target" "this" {
  min_capacity = 1
  max_capacity = 2
  resource_id = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
  // role_arn not necessary as AWS creates and uses a service-linked role in your account:
  // AWSServiceRoleForApplicationAutoScaling_ECSService
  // See https://docs.aws.amazon.com/IAM/latest/UserGuide/using-service-linked-roles.html
}

resource "aws_appautoscaling_policy" "this" {
  name = "${local.service_name}"
  policy_type = "TargetTrackingScaling"
  resource_id = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"

  target_tracking_scaling_policy_configuration {
    target_value = 10
    scale_in_cooldown = 300
    scale_out_cooldown = 60

    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${data.terraform_remote_state.vpc.alb_arn_suffix}/${aws_lb_target_group.this.arn_suffix}"
    }
  }

  depends_on = ["aws_appautoscaling_target.this"]
}