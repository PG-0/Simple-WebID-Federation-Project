### This module is to create two s3 buckets, one for private and one for public access###

locals {
    common_tags = {
        Terraform   = "True"
    }
}

# Random Naming for buckets
resource "random_pet" "bucket_name" {
  length    = 3
  separator = "-"
}

## Public Bucket appbucket

# Create appbucket
resource "aws_s3_bucket" "appbucket" {
  bucket = "appbucket-${random_pet.bucket_name.id}"

  tags = local.common_tags
}

# Allow access to appbucket
resource "aws_s3_bucket_public_access_block" "appbucket_access" {
  bucket = aws_s3_bucket.appbucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# appbucket Website Config
resource "aws_s3_bucket_website_configuration" "appbucket_web_config" {
  bucket = aws_s3_bucket.appbucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# appbucket file upload
resource "aws_s3_object" "pub_files" {
  depends_on = [aws_s3_bucket.appbucket]
  bucket = aws_s3_bucket.appbucket.id

  for_each = var.pub_S3_files_to_upload

  key          = basename(each.key)
  source       = each.key
  content_type = each.value
}

# Bucket access policy setup for appbucket
resource "aws_s3_bucket_policy" "appbucket_policy" {
  bucket = aws_s3_bucket.appbucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadForGetBucketObjects"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.appbucket.arn}/*"
      }
    ]
  })
}

## Private Bucket
# Create Bucket
resource "aws_s3_bucket" "privatebucket" {
  bucket = "privatebucket-${random_pet.bucket_name.id}"

  tags = local.common_tags
}


# Private bucket file upload
resource "aws_s3_object" "private_files" {
  depends_on = [aws_s3_bucket.privatebucket]
  bucket = aws_s3_bucket.appbucket.id

  for_each = var.private_S3_files_to_upload

  key          = basename(each.key)
  source       = each.key
  content_type = each.value
}

# Setup CORs config for private bucket
resource "aws_s3_bucket_cors_configuration" "privatebucket_cors" {
  bucket = aws_s3_bucket.privatebucket.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
  }
}

# Privatebucket policy
resource "aws_iam_policy" "private_patches_policy" {
  name        = "PrivatePatchesPermissions"
  description = "Permissions to List contents of the privatepatches bucket"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "ReadFromLCBucket"
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
        ]
        Resource = [
          "${aws_s3_bucket.privatebucket.arn}",
          "${aws_s3_bucket.privatebucket.arn}/*",
        ]
      },
    ]
  })
}