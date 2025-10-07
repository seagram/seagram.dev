output "website_url" {
  value       = "https://${var.root_domain_name}"
}

output "cloudfront_distribution_id" {
  value       = module.cloudfront.distribution_id
}

output "s3_bucket_name" {
  value       = module.s3_bucket.bucket_id
}

output "route53_zone_id" {
  value       = module.route53_zone.zone_id
}

output "route53_name_servers" {
  value       = module.route53_zone.zone_name_servers
}
