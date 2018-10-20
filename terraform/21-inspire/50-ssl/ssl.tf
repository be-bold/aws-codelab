// This is the ssl certificate
resource "aws_acm_certificate" "this" {
  domain_name = "team1.codelab.marcelboettcher.de"
  validation_method = "DNS"
  tags = "${local.default_tags}"

  lifecycle {
    create_before_destroy = true
  }
}

// The Amazon Certificate Manager (ACM) provides you with a generated and unique dns record name and value.
// This must be added to your route53 hosted zone of the domain name. If aws_acm_certificate_validation
// can retrieve the correct values via dns requests, it proves that you own the domain and the certificate validation
// is successful.
resource "aws_route53_record" "cert_validation" {
  zone_id = "${data.aws_route53_zone.this.id}"
  name = "${aws_acm_certificate.this.domain_validation_options.0.resource_record_name}"
  type = "${aws_acm_certificate.this.domain_validation_options.0.resource_record_type}"
  records = ["${aws_acm_certificate.this.domain_validation_options.0.resource_record_value}"]
  ttl = 60
}

// Warning: This resource implements a part of the validation workflow. It checks the dns record until its published.
// It does not represent a real-world entity in AWS.
resource "aws_acm_certificate_validation" "this" {
  certificate_arn = "${aws_acm_certificate.this.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}