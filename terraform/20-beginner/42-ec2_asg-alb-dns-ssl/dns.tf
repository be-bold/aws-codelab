resource "aws_route53_record" "alb" {
  name = "team1.codelab.marcelboettcher.de"
  zone_id = data.aws_route53_zone.this.id
  type = "A"

  alias {
    evaluate_target_health = true
    name = aws_lb.this.dns_name
    zone_id = aws_lb.this.zone_id
  }
}

