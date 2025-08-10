output "bucket_url" {
  value = "s3://${module.s3.bucket_id}"
}

output "website_url" {
  value = "https://${local.root_domain_name}"
}

output "cloudfront_distribution_id" {
  value = module.cloudfront.distribution_id
}