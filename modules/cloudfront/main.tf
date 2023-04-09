resource "aws_cloudfront_distribution" "web_app_cdn" {
  enabled = true

  default_cache_behavior {
    cached_methods  = ["GET", "HEAD"]
    allowed_methods = ["GET", "HEAD"]
    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
    }
    target_origin_id       = var.origin_id
    viewer_protocol_policy = "https-only"
  }

  default_root_object = var.default_root_object

  origin {
    domain_name = var.domain_name
    origin_id   = var.origin_id
    s3_origin_config {
      origin_access_identity = ""
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}









# resource "aws_cloudfront_distribution" "web_app_cdn" {
#   depends_on = [module.s3]

#   enabled = true

#   default_cache_behavior {
#     cached_methods  = ["GET", "HEAD"]
#     allowed_methods = ["GET", "HEAD"]
#     forwarded_values {
#       query_string = true
#       cookies {
#         forward = "all"
#       }
#     }
#     target_origin_id       = "appbucket"
#     viewer_protocol_policy = "https-only"
#   }

#   default_root_object = "index.html"

#   origin {
#     domain_name = module.s3.appbucket_domain_name
#     origin_id   = "appbucket"
#     s3_origin_config {
#       origin_access_identity = ""
#     }
#   }

#     restrictions {
#         geo_restriction {
#         restriction_type = "whitelist"
#         locations        = ["US", "CA"]
#     }
#   }

#   viewer_certificate {
#     cloudfront_default_certificate = true
#   }
# }