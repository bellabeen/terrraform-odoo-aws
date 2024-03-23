terraform {
  backend "s3" {
    bucket = "terraform-state-lab-bellabeen"
    key    = "prod"
    region = "ap-southeast-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
  }
  required_version = ">= 1.2.0"
}