terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.16.1"
    }
  }
    backend "s3" {
    bucket = "robokart"
    key    = "vpc-advanced"
    region = "us-east-1"
    dynamodb_table = "robokart_dynamotable"
    }
  }

provider "aws" {
  # Configuration options
}