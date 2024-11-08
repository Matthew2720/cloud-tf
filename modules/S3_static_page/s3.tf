## Creación del bucket
resource "aws_s3_bucket" "bucket-web-site" {
  bucket = var.bucket_name
  tags = {
    Environment = "lab"
  }
}

## Control de accesso al bucket desde cloudfront.
resource "aws_cloudfront_origin_access_control" "access-Control" {
  name                              = var.oac-name
  description                       = "OAC setup for security liderapp"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

## Distribución CloudFront
resource "aws_cloudfront_distribution" "access-Control" {
  depends_on = [
    aws_s3_bucket.bucket-web-site,
    aws_cloudfront_origin_access_control.access-Control
  ]

  origin {
    domain_name              = aws_s3_bucket.bucket-web-site.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.bucket-web-site.id
    origin_access_control_id = aws_cloudfront_origin_access_control.access-Control.id
  }

  enabled             = true
  default_root_object = "index.html"
  
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "CO"]
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket.bucket-web-site.id
    viewer_protocol_policy = "https-only"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }

    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

## Política de acceso al bucket
resource "aws_s3_bucket_policy" "origin" {
  depends_on = [
    aws_cloudfront_distribution.access-Control
  ]
  bucket = aws_s3_bucket.bucket-web-site.id
  policy = data.aws_iam_policy_document.origin.json
}

data "aws_iam_policy_document" "origin" {
  depends_on = [
    aws_cloudfront_distribution.access-Control,
    aws_s3_bucket.bucket-web-site
  ]
  statement {
    sid    = "3"
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    principals {
      identifiers = ["cloudfront.amazonaws.com"]
      type        = "Service"
    }
    resources = [
      "arn:aws:s3:::${aws_s3_bucket.bucket-web-site.bucket}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [
        aws_cloudfront_distribution.access-Control.arn
      ]
    }
  }
}

## Versionado bucket
resource "aws_s3_bucket_versioning" "bucket-web-site" {
  bucket = aws_s3_bucket.bucket-web-site.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

## Subir página
resource "aws_s3_object" "content" {
  depends_on = [
    aws_s3_bucket.bucket-web-site
  ]
  bucket                 = aws_s3_bucket.bucket-web-site.id
  key                    = "index.html"
  source                 = "modules/S3_static_page/site/index.html"
  server_side_encryption = "AES256"

  content_type = "text/html"
}
