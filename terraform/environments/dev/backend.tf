terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    porkbun = {
      source  = "kyswtn/porkbun"
      version = "0.1.3"
    }
  }

  required_version = ">= 1.0"
}
