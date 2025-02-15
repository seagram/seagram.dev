terraform {
  backend "remote" {
    organization = "seagram"
    workspaces {
      prefix = "seagram_dev-"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.1"
    }
    porkbun = {
      source  = "kyswtn/porkbun"
      version = "0.1.3"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "porkbun" {
  api_key        = var.porkbun_api_key
  secret_api_key = var.porkbun_secret_api_key
}

