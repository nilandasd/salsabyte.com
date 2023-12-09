resource "aws_s3_bucket" "public" {
  bucket = "${local.project}-public-folder-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_policy" "read_public" {
  bucket = aws_s3_bucket.public.id
  policy = data.aws_iam_policy_document.read_public_bucket.json
}

resource "aws_s3_bucket_public_access_block" "public" {
  bucket = aws_s3_bucket.public.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "public" {
  depends_on = [
    aws_s3_bucket_public_access_block.public,
  ]

  bucket = aws_s3_bucket.public.id
  acl    = "public-read"
}

resource "aws_cloudfront_origin_access_identity" "public" {}

resource "aws_cloudfront_distribution" "public" {
  origin {
    domain_name = aws_s3_bucket.public.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.public.id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.public.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100"
  http_version        = "http2"
  aliases             = ["public.salsabyte.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.public.id

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl               = 0
    default_ttl           = 3600
    max_ttl               = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
   acm_certificate_arn      = aws_acm_certificate.public.arn
   ssl_support_method       = "sni-only"
   minimum_protocol_version = "TLSv1.2_2021"
 }
}

data "aws_iam_policy_document" "read_public_bucket" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.public.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.public.iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.public.arn]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.public.iam_arn]
    }
  }
}
