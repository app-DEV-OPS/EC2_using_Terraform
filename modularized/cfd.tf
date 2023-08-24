resource "aws_cloudfront_distribution" "hga-lamp-cfd" {
  origin {
    domain_name = "aws_lb.hga-lamp-alba.name"
    origin_id   = "aws_lb.hga-lamp-alba.id"
    cloudfront_distribution_enabled = true   # enable CloudFront distribution
    is_ipv6_enabled     = true
    comment             = "CloudFront distribution for staging"
    
	alias {
    name                   = "aws_route53_record.name"
    zone_id                = "aws_route53_zone.id"
    evaluate_target_health = false
  }
}
    default_cache_behavior {
		
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "aws_lb.hga-lamp-alba.name"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0        # min time for objects to live in the distribution cache
    default_ttl            = 3600     # default time for objects to live in the distribution cache
    max_ttl                = 86400    # max time for objects to live in the distribution cache
  }

  restrictions {
    geo_restriction {
        restriction_type = "none"
    }
  }

  viewer_certificate {
    # cloudfront_default_certificate = true   # use this if you don't have certificate
    acm_certificate_arn = aws_acm_certificate.hga-lamp-cfd-cert.arn
    ssl_support_method = "sni-only"
  }

  depends_on = [aws_acm_certificate.hga-lamp-cfd-cert]
}
