 module allow_all_sg {
  source = "../terraform-aws-securitygroup"
  sg_name = var.sg_name
  sg_description = var.sg_description
  project_name = var.project_name
  sg_ingress_rules = var.sg_ingress_rules
  vpc_id = local.vpc_id
}