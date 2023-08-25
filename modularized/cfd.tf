data "aws_route53_zone" "hga-lamp-zone" {

name = "${aws_route53_zone.hga-lamp-zone.name}"


}
data "aws_lb" "hga-lamp-alb" {

name =  "{aws_lb.hga-lamp-alb.name}"
}

data "aws_acm_certificate" "hga-lamp-cfd-cert" {

domain = "${aws_route53_zone.hga-lamp-zone.name}"


}
resource "aws_cloudfront_distribution" "hga-lamp-cfd" {
  enabled             = true
  aliases             = [aws_route53_zone.hga-lamp-zone.name]

  origin {
    domain_name = "{aws_lb.aws_lb.hga-lamp-alb.name}"
    origin_id   = "{aws_lb.hga-lamp-alb.id}"

  }
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = aws_cloudfront_distribution.hga-lamp-cfd.id
    viewer_protocol_policy = "redirect-to-https" 
    forwarded_values {
      headers      = []
      query_string = true
      cookies {
        forward = "all"
      }
    }

   # min time for objects to live in the distribution cache
    default_ttl            = 3600     # default time for objects to live in the distribution cache
    max_ttl                = 86400    # max time for objects to live in the distribution cache
  }
viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.hga-lamp-cfd-cert.arn
    ssl_support_method = "sni-only"
#depends_on = [aws_acm_certificate.hga-lamp-cfd-cert]
  }

  restrictions {
    geo_restriction {
        restriction_type = "none"
    }
  }


  }

  


