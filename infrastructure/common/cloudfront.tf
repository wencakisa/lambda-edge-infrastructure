resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.bucket.website_endpoint
    origin_id   = var.s3_origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Image resize Lambda@Edge mechanism"
  default_root_object = "index.html"

  # Disable the distribution instead of deleting it (when `terraform destroy` is fired)
  retain_on_delete = true
  # Do not wait the distribution status to change from `In Progress` to `Deployed`
  # because it takes approximately 15-20min.
  wait_for_deployment = false

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.s3_origin_id

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 31536000

    forwarded_values {
      query_string            = true
      query_string_cache_keys = ["d"]

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = aws_lambda_function.viewer_request.qualified_arn
      include_body = true
    }

    lambda_function_association {
      event_type   = "origin-response"
      lambda_arn   = aws_lambda_function.origin_response.qualified_arn
      include_body = false
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    # Uncomment this when we have proper CNAME for this Cloudfront distribution
    # acm_certificate_arn = var.acm_certificate_arn

    cloudfront_default_certificate = true
  }

  depends_on = [aws_s3_bucket.bucket]
}
