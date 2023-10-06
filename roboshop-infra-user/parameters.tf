resource "aws_ssm_parameter" "vpc_id" {
  name  = "/roboshop/dev/vpc_id"
  type  = "String"
  value = local.vpc_id
}

resource "aws_ssm_parameter" "public_cidr_block" {
  name  = "/roboshop/dev/public_cidr_block"
  type  = "StringList"
  value = join(",", local.public_cidr_block)
}

resource "aws_ssm_parameter" "private_cidr_block" {
  name  = "/roboshop/dev/private_cidr_block"
  type  = "StringList"
  value = join(",", local.private_cidr_block)
}

resource "aws_ssm_parameter" "database_cidr_block" {
  name  = "/roboshop/dev/database_cidr_block"
  type  = "StringList"
  value = join(",", local.database_cidr_block)
}


resource "aws_ssm_parameter" "allow_all_security_group_id" {
  name  = "/roboshop/dev/allow_all_security_group_id"
  type  = "String"
  value = local.allow_all_security_group_id
}




