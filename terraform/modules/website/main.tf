resource "aws_route53_record" "certvalidation" {
  for_each = {
    for d in aws_acm_certificate.cert.domain_validation_options : d.domain_name => {
      name   = d.resource_record_name
      record = d.resource_record_value
      type   = d.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for r in aws_route53_record.certvalidation : r.fqdn]
}

resource "aws_acm_certificate" "cert" {
  domain_name               = var.root_domain_name
  subject_alternative_names = var.domain_aliases
  validation_method         = "DNS"
}

locals {
  s3_origin_id = var.root_domain_name
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    domain_name              = var.s3_bucket_regional_domain_name
    origin_id                = local.s3_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  default_root_object = "index.html"
  aliases             = concat(var.domain_aliases, [var.root_domain_name])

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    function_association {
      event_type   = "viewer-request"
      function_arn = aws_cloudfront_function.index.arn
    }

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = var.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${replace(var.root_domain_name, ".", "-")}-cloudfront-s3-oac"
  description                       = "CloudFront S3 OAC for ${var.root_domain_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_function" "index" {
  name    = "${replace(var.root_domain_name, ".", "-")}-index"
  runtime = "cloudfront-js-2.0"
  code    = file("${path.module}/index.js")
}

resource "porkbun_nameservers" "nameservers" {
  domain      = var.root_domain_name
  nameservers = var.route53_zone_name_servers
}

resource "aws_route53_record" "main-record" {
  zone_id = var.zone_id
  name    = var.root_domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias-record" {
  count   = length(var.domain_aliases)
  zone_id = var.zone_id
  name    = var.domain_aliases[count.index]
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "spf_txt" {
  zone_id = var.zone_id
  name    = var.root_domain_name
  type    = "TXT"
  ttl     = 300
  records = ["v=spf1 mx include:_spf.porkbun.com ~all"]
}

resource "aws_route53_zone" "zone" {
  name = var.root_domain_name
}


resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucketname
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership,
    aws_s3_bucket_public_access_block.access
  ]

  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.cloudfront_access.json
}

data "aws_iam_policy_document" "cloudfront_access" {
  statement {
    sid    = "AllowCloudFrontS3Access"
    effect = "Allow"

    resources = [
      "${aws_s3_bucket.bucket.arn}",
      "${aws_s3_bucket.bucket.arn}/*",
    ]

    actions = ["s3:GetObject"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
  }
}

locals {
  sensitive_secrets = {
    porkbun_api_key        = var.porkbun_api_key
    porkbun_secret_api_key = var.porkbun_secret_api_key
  }
}

resource "aws_secretsmanager_secret" "sensitive_secrets" {
  for_each = local.sensitive_secrets
  name     = "seagram-dev/${each.key}"
}

resource "aws_secretsmanager_secret_version" "sensitive_secrets" {
  for_each      = local.sensitive_secrets
  secret_id     = aws_secretsmanager_secret.sensitive_secrets[each.key].id
  secret_string = each.value
}

data "aws_secretsmanager_secret" "sensitive_secrets" {
  for_each = local.sensitive_secrets
  name     = aws_secretsmanager_secret.sensitive_secrets[each.key].name
}

data "aws_secretsmanager_secret_version" "sensitive_secrets" {
  for_each   = local.sensitive_secrets
  secret_id  = data.aws_secretsmanager_secret.sensitive_secrets[each.key].id
  depends_on = [aws_secretsmanager_secret_version.sensitive_secrets]
}


