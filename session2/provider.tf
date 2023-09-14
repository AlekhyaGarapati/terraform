terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.1"
    }
  }
    backend "s3" {
    bucket = "robakart-s3-bucket"
    key    = "conditions"
    region = "us-east-1"
    dynamodb_table = "robokat-locking"
  
  }
}

provider "aws" {
  # Configuration options
}