data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.project_name}/${var.env}/vpc_id"
}

data  "aws_ssm_parameter" "vpn_sg_id" {
    name = "/${var.project_name}/${var.env}/vpn_sg_id"
}
data "aws_ssm_parameter" "mongodb_sg_id" {
    name = "/${var.project_name}/${var.env}/mongodb_sg_id"
}

data  "aws_ssm_parameter" "database_cidr_block" {
    name = "/${var.project_name}/${var.env}/database_cidr_block"
}

data "aws_ami" "ami_id" {
  most_recent      = true
  name_regex       = "Centos-8-DevOps-Practice" #ami-name for ami devops_practice
  owners           = ["973714476881"] #owner of for ami devops_practice

  filter {
    name   = "name"
    values = ["Centos-8-DevOps-Practice"]  #ami-name for ami devops_practice
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"] # default value
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"] # default value
  }
}