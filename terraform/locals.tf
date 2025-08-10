data "aws_secretsmanager_secret_version" "porkbun_api_key" {
  secret_id = "seagram-dev/porkbun_api_key"
}

data "aws_secretsmanager_secret_version" "porkbun_secret_api_key" {
  secret_id = "seagram-dev/porkbun_secret_api_key"
}

locals {
  porkbun_api_key        = data.aws_secretsmanager_secret_version.porkbun_api_key.secret_string
  porkbun_secret_api_key = data.aws_secretsmanager_secret_version.porkbun_secret_api_key.secret_string

  bucketname       = "seagram-bucket"
  root_domain_name = "seagram.dev"
  domain_aliases   = ["www.seagram.dev"]
  bucket_name      = "seagram-terraform-state"
}