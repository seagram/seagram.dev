data "aws_secretsmanager_secret" "porkbun_api_key" {
  name = "seagram-dev/porkbun_api_key"
}

data "aws_secretsmanager_secret" "porkbun_secret_api_key" {
  name = "seagram-dev/porkbun_secret_api_key"
}

data "aws_secretsmanager_secret_version" "porkbun_api_key" {
  secret_id = data.aws_secretsmanager_secret.porkbun_api_key.id
}

data "aws_secretsmanager_secret_version" "porkbun_secret_api_key" {
  secret_id = data.aws_secretsmanager_secret.porkbun_secret_api_key.id
}

locals {
  porkbun_api_key        = data.aws_secretsmanager_secret_version.porkbun_api_key.secret_string
  porkbun_secret_api_key = data.aws_secretsmanager_secret_version.porkbun_secret_api_key.secret_string

  bucketname       = "seagram-bucket"
  root_domain_name = "seagram.dev"
  domain_aliases   = ["www.seagram.dev"]
  bucket_name      = "seagram-terraform-state"
}