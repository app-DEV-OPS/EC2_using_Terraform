data "aws_cloudfront_distribution" "hga-lamp-cfd" {
id = "${aws_cloudfront_distribution.hga-lamp-cfd.id}"

}
resource "aws_route53_zone" "hga-lamp-zone" {
name = "lamp.com"
vpc {
vpc_id = "aws_vpc.hga-vpc-tf-test.id"
}
tags = {
   env = "hga-lamp-zone"
}
}
resource "aws_route53_record" "hga-lamp-record" {
zone_id = "${aws_route53_zone.hga-lamp-zone.id}"
name = "hga.lamp.com"
type = "A"
alias {
    name              = "${aws_cloudfront_distribution.hga-lamp-cfd.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.hga-lamp-cfd.id}"
    evaluate_target_health = false
  }
}

