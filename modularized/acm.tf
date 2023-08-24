resource "aws_acm_certificate" "hga-lamp-cfd-cert" {
 domain_name = "aws_route53_zone.name"
  validation_method = "DNS"

  tags = {
      name = "hga-lamp-cfd-cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}
