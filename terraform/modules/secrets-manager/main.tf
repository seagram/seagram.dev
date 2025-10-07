resource "aws_secretsmanager_secret" "secret" {
  for_each                = var.secrets
  name                    = "${var.name_prefix}${each.key}"
  description             = each.value.description
  recovery_window_in_days = var.recovery_window_in_days

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  for_each      = var.secrets
  secret_id     = aws_secretsmanager_secret.secret[each.key].id
  secret_string = each.value.value
}
