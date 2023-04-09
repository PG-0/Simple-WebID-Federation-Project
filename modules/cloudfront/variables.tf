variable "domain_name" {
  type        = string
  description = "The domain name of the S3 bucket"
}

variable "origin_id" {
  type        = string
  description = "A unique identifier for the origin of the distribution"
}

variable "default_root_object" {
  type        = string
  description = "The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL"
}