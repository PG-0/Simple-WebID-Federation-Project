terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "./modules/s3"
}

module "cloudfront" {
  source = "./modules/cloudfront"
  domain_name = module.s3.appbucket_domain_name
  origin_id = "appbucket"
  default_root_object = "index.html"
  depends_on = [module.s3]
}
