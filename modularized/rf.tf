resource "aws_route53_zone" "hga-lamp-zone" {

name = "lamp.com"

}

resource "aws_route53_record" "hga-lamp-record-a" {
zone_id = "aws_route53_zone.hga-lamp-zone.id"
name = "hga.lamp.com"
type = "A"
alias {
    name                   = "aws_cloudfront_distribution.name"
    zone_id                = "aws_cloudfront_distribution.id"
    evaluate_target_health = false
  }
}
