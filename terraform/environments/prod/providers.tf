provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }
}

provider "porkbun" {
  api_key        = var.porkbun_api_key
  secret_api_key = var.porkbun_secret_api_key
}