terraform {
  backend "s3" {
    bucket         = "seagram-terraform-state-bucket"
    key            = "bootstrap/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "seagram-terraform-locks-table"
    encrypt        = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  default_tags {
    tags = {
      Project    = "bootstrap"
      Owner      = "cal-seagram"
      CostCenter = "personal"
      CreatedBy  = "terraform"
    }
  }
}
