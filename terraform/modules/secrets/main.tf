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
    porkbun_api_key          = var.porkbun_api_key
    porkbun_secret_api_key   = var.porkbun_secret_api_key
  }
}

resource "aws_secretsmanager_secret" "sensitive_secrets" {
  for_each = local.sensitive_secrets
  name     = "seagram-dev/${each.key}"
}

resource "aws_secretsmanager_secret_version" "sensitive_secrets" {
  for_each      = local.sensitive_secrets
  secret_id     = aws_secretsmanager_secret.sensitive_secrets[each.key].id
  secret_string = each.value
}