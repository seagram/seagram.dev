data "aws_secretsmanager_secret_version" "phone_number" {
  secret_id = "general/phone_number"
}

data "aws_secretsmanager_secret_version" "email" {
  secret_id = "general/email"
}

locals {
  phone_number = data.aws_secretsmanager_secret_version.phone_number.secret_string
  email        = data.aws_secretsmanager_secret_version.email.secret_string
}