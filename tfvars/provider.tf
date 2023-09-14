terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.1"
    }
  }
    backend "s3" {
    bucket = "robokart-s3-dev"
    key    = "tfvars"
    region = "us-east-1"
    dynamodb_table = "robokart-dev"
  
  }
}

provider "aws" {
  # Configuration options
}