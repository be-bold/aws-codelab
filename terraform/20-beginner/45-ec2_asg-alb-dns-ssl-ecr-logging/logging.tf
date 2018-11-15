resource "aws_cloudwatch_log_group" "web_server" {
  name = "team1/service1"
  retention_in_days = 1
}