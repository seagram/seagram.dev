output "bucket_url" {
  value = "s3://${aws_s3_bucket.bucket.id}"
}

output "website_url" {
  value = "https://${var.root_domain_name}"
}

output "cloudfront_distribution_id" {
  value = aws_cloudfront_distribution.distribution.id
}
