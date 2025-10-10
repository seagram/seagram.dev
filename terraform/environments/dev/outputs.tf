output "website_url" {
  value       = "https://${local.root_domain_name}"
}

output "cloudfront_distribution_id" {
  value       = module.cloudfront.distribution_id
}

output "s3_bucket_name" {
  value       = module.s3-website.bucket_id
}

output "route53_zone_id" {
  value       = module.route53_zone.zone_id
}

output "route53_name_servers" {
  value       = module.route53_zone.zone_name_servers
}

output "cloudwatch_dashboard_url" {
  value       = module.cloudwatch.dashboard_url
  description = "URL to the CloudWatch analytics dashboard"
}

output "cloudwatch_dashboard_name" {
  value       = module.cloudwatch.dashboard_name
  description = "Name of the CloudWatch dashboard"
}
