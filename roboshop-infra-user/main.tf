module roboshop_infra_advanced {
 source = "../terraform-aws-vpc-advanced"
 cidr_block = var.cidr_block
 common_tags = var.common_tags
 project_name = var.project_name
 public_cidr_block = var.public_cidr_block
 private_cidr_block = var.private_cidr_block
 database_cidr_block = var.database_cidr_block
 }