data "aws_ssm_parameter" "app_alb_sg_id" {
    name = "/${var.project_name}/${var.env}/app_alb_sg_id"
}

data "aws_ssm_parameter" "private_cidr_block" {
  name  =  "/${var.project_name}/${var.env}/private_cidr_block"
}