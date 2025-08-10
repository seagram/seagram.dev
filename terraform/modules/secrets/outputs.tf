data "aws_secretsmanager_secret" "sensitive_secrets" {
  for_each = local.sensitive_secrets
  name     = aws_secretsmanager_secret.sensitive_secrets[each.key].name
}

data "aws_secretsmanager_secret_version" "sensitive_secrets" {
  for_each  = local.sensitive_secrets
  secret_id = data.aws_secretsmanager_secret.sensitive_secrets[each.key].id
  depends_on = [aws_secretsmanager_secret_version.sensitive_secrets]
}

output "porkbun_api_key" {
  value     = data.aws_secretsmanager_secret_version.sensitive_secrets["porkbun_api_key"].secret_string
  sensitive = true
}

output "porkbun_secret_api_key" {
  value     = data.aws_secretsmanager_secret_version.sensitive_secrets["porkbun_secret_api_key"].secret_string
  sensitive = true
}
