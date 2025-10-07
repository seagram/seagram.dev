output "secret_arns" {
  value       = { for k, v in aws_secretsmanager_secret.secret : k => v.arn }
}

output "secret_ids" {
  value       = { for k, v in aws_secretsmanager_secret.secret : k => v.id }
}
