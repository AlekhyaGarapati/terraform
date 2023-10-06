resource "aws_ssm_parameter" "vpc_id" {
  name  =  "/${var.project_name}/${var.env}/vpc_id"
  type  = "String"
  value = local.vpc_id
}

resource "aws_ssm_parameter" "public_cidr_block" {
  name  = "/${var.project_name}/${var.env}/public_cidr_block"
  type  = "StringList"
  value = join(",", local.public_cidr_block)
}

resource "aws_ssm_parameter" "private_cidr_block" {
  name  =  "/${var.project_name}/${var.env}/private_cidr_block"
  type  = "StringList"
  value = join(",", local.private_cidr_block)
}

resource "aws_ssm_parameter" "database_cidr_block" {
  name  =  "/${var.project_name}/${var.env}/database_cidr_block"
  type  = "StringList"
  value = join(",", local.database_cidr_block)
}


