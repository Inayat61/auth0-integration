locals {
  bucket_name="auth0-integration-helloworld-react-app-bucket"
}

# Create s3 bucket using s3-bucket module 
module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = local.bucket_name
  acl    = "public-read"

  versioning = {
    enabled = true
  }

  control_object_ownership = true
  object_ownership         = "BucketOwnerPreferred"

  # allow cloudfront access to the bucket
  attach_policy = true
  policy        = data.aws_iam_policy_document.s3_bucket_policy.json

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
}

# Policy to be attached to the S3 bucket to allow CloudFront access
data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.s3_bucket.s3_bucket_arn}/*"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [module.cloudfront.cloudfront_distribution_arn]
    }
  }
}



module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 3.2.0"

  origin = {
    s3 = {
      domain_name = module.s3_bucket.s3_bucket_bucket_regional_domain_name
      origin_id   = local.bucket_name
      origin_access_control = "s3" 
    }
  }


  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CloudFront Distribution pointing to ${local.bucket_name}"
  default_root_object = "index.html"
  price_class         = "PriceClass_All"
  create_origin_access_control = true

  origin_access_control = {
    s3 = {
      description      = "CloudFront access to S3"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }



  default_cache_behavior = {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.bucket_name
    forwarded_values = {
      query_string = false
      cookies = {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  viewer_certificate = {
    cloudfront_default_certificate = true
  }
}
