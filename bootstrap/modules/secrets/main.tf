terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

locals {
  sensitive_secrets = {
    phone_number = var.phone_number
    email       = var.email
  }
}

resource "aws_secretsmanager_secret" "sensitive_secrets" {
  for_each                = local.sensitive_secrets
  name                    = "general/${each.key}"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "sensitive_secrets" {
  for_each      = local.sensitive_secrets
  secret_id     = aws_secretsmanager_secret.sensitive_secrets[each.key].id
  secret_string = each.value
}