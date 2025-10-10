
output "zone_id" {
  value = aws_route53_zone.zone.zone_id
}

output "zone_name_servers" {
  value = aws_route53_zone.zone.name_servers
}


output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.bucket.bucket_regional_domain_name
}


output "porkbun_api_key" {
  value     = data.aws_secretsmanager_secret_version.sensitive_secrets["porkbun_api_key"].secret_string
  sensitive = true
}

output "porkbun_secret_api_key" {
  value     = data.aws_secretsmanager_secret_version.sensitive_secrets["porkbun_secret_api_key"].secret_string
  sensitive = true
}


output "validated_certificate_arn" {
  value = aws_acm_certificate_validation.validation.certificate_arn
}

output "distribution_id" {
  value = aws_cloudfront_distribution.distribution.id
}

output "distribution_domain_name" {
  value = aws_cloudfront_distribution.distribution.domain_name
}

output "distribution_hosted_zone_id" {
  value = aws_cloudfront_distribution.distribution.hosted_zone_id
}

