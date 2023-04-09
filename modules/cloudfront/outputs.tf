output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.web_app_cdn.domain_name
  description = "The domain name of the CloudFront distribution"
}

output "cloudfront_id" {
  value       = aws_cloudfront_distribution.web_app_cdn.id
  description = "The unique identifier for the CloudFront distribution"
}