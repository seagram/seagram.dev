output "dashboard_name" {
  value       = aws_cloudwatch_dashboard.analytics.dashboard_name
}

output "dashboard_url" {
  value       = "https://console.aws.amazon.com/cloudwatch/home?region=us-east-1#dashboards:name=${aws_cloudwatch_dashboard.analytics.dashboard_name}"
}
