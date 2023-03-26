# Terraform Block
terraform {
  required_version = ">=1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "poctestingcicd"
    key    = "terraform-config/dev/tf-cicd-config.tfstate"
    region = "us-east-1"
  }
}

# Provider Block
provider "aws" {
  region  = var.aws_region
  profile = "default"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/