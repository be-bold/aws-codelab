// Attention: This setup is not production ready as we load the autoscaling group via data source,
// which causes some problems:
// If you change the autoscaling group you must apply this configuration again.
// This does not work during a deployment as two autoscaling groups exist.

resource "aws_autoscaling_policy" "this" {
  name = "${local.basename}-target-tracking-scaling"
  autoscaling_group_name = "${data.aws_autoscaling_groups.web_server.names[0]}"

  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      // Valid metrics: https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_PredefinedMetricSpecification.html
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label = "${data.aws_lb.this.arn_suffix}/${data.aws_lb_target_group.web_server.arn_suffix}"
    }
    target_value = 10 // requests per target per minute
  }
}