output "secrets_created" {
  description = "Confirmation that secrets have been created"
  value       = "Phone number and email secrets created in AWS Secrets Manager"
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic for budget alerts"
  value       = module.sns.sns_topic_arn
}

output "budget_name" {
  description = "Name of the created budget"
  value       = "budget-general-monthly"
}
