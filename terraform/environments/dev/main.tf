terraform {
  backend "s3" {
    bucket       = "seagram-terraform-state-bucket"
    # key          = "seagram-dev/dev/terraform.tfstate"
    key          = "seagram-dev/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }

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
}

provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      Project     = "seagram.dev"
      Environment = "dev"
      Owner       = "cal-seagram"
      CostCenter  = "personal"
      CreatedBy   = "terraform"
    }
  }
}

provider "porkbun" {
  api_key        = var.porkbun_api_key
  secret_api_key = var.porkbun_secret_api_key
}
