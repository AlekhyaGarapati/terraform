module vpn_sg {
  source = "../../terraform-aws-securitygroup"
  sg_name = "roboshop_vpn_sg"
  sg_description = "allowing traffic to all ports from my home ip"
  project_name = var.project_name

  #best practice is to define ingress rules in aws_security_group_rule resource instead of creating here
  #sg_ingress_rules = var.sg_ingress_rules

  vpc_id = data.aws_vpc.default_vpc.id  #vpn instance in created in default vpc, so provided default vpc id
  common_tags = merge (
    var.common_tags,
    {
        Component = "vpn"
        Name = "roboshop_vpn_sg"
    }
  )
}

module mongodb_sg {
  source = "../../terraform-aws-securitygroup"
  sg_name = "mongodb_sg"
  sg_description = "allowing traffic on 27017 port from catalogue "
  project_name = var.project_name
  vpc_id = data.aws_ssm_parameter.vpc_id.value #roboshop vpc id as mongodb is installed in robodhop vpc
  common_tags = merge (
    var.common_tags,
    {
        Component = "mongodb"
        Name = "mongodb_sg"
    }
  )
}

module catalogue_sg {
  source = "../../terraform-aws-securitygroup"
  sg_name = "catalogue_sg"
  sg_description = "allowing traffic on 8080 port from app-alb "
  project_name = var.project_name
  vpc_id = data.aws_ssm_parameter.vpc_id.value #roboshop vpc id as mongodb is installed in robodhop vpc
  common_tags = merge (
    var.common_tags,
    {
        Component = "catalogue"
        Name = "catalogue_sg"
    }
  )
}

module app_alb_sg {
  source = "../../terraform-aws-securitygroup"
  sg_name = "app_alb_sg"
  sg_description = "allowing traffic on 80 port from web,catalogue,cart,user,shipping,payment "
  project_name = var.project_name
  vpc_id = data.aws_ssm_parameter.vpc_id.value 
  common_tags = merge (
    var.common_tags,
    {
        Component = "app_alb"
        Name = "app_alb_sg"
    }
  )
}

module web_sg {
  source = "../../terraform-aws-securitygroup"
  sg_name = "web_sg"
  sg_description = "allowing traffic on 80 port from web-alb"
  project_name = var.project_name
  vpc_id = data.aws_ssm_parameter.vpc_id.value 
  common_tags = merge (
    var.common_tags,
    {
        Component = "web"
        Name = "web_sg"
    }
  )
}


module web_alb_sg {
  source = "../../terraform-aws-securitygroup"
  sg_name = "web_alb_sg"
  sg_description = "allowing traffic on 443 port from internet"
  project_name = var.project_name
  vpc_id = data.aws_ssm_parameter.vpc_id.value 
  common_tags = merge (
    var.common_tags,
    {
        Component = "web_alb"
        Name = "web_alb_sg"
    }
  )
}


resource "aws_security_group_rule" "vpn_sg_rule" {
  type              = "ingress"
  description       = "allowing traffic to all ports(0 to 65535) from my home ip"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.myip.body)}/32"] #ip address from my laptop 
  security_group_id = module.vpn_sg.sg_id #sg_id is delcared in output variable in module..so we are fetching it here.
}

# mongodb
# -------
# should allow traffic on port 22 (for troubleshooting) from VPN (source - vpn)
# should allow traffic on port 27070 from catalogue.(source - catalogue

resource "aws_security_group_rule" "mongodb_from_vpn" {
  type              = "ingress"
  description       = "allowing traffic on port 22 (for troubleshooting) from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id #here source is vpn, so sg rules of vpn will be applicable to mongodb
  security_group_id = module.mongodb_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}


resource "aws_security_group_rule" "mongodb_from_catalogue" {
  type              = "ingress"
  description       = "allowing traffic on port 27070 from catalogue"
  from_port         = 27070
  to_port           = 27070
  protocol          = "tcp"
  source_security_group_id = module.catalogue_sg.sg_id
  security_group_id = module.mongodb_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

# catalogue
# ---------
# should allow traffic on port 22 (for troubleshooting) from VPN (source - vpn)
# should allow traffic on port 8080 from app_alb.(source - app_alb)

resource "aws_security_group_rule" "catalogue_from_vpn" {
  type              = "ingress"
  description       = "allowing traffic on port 22 (for troubleshooting) from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id #here source is vpn, so sg rules of vpn will be applicable to mongodb
  security_group_id = module.catalogue_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

resource "aws_security_group_rule" "catalogue_from_app_alb" {
  type              = "ingress"
  description       = "allowing traffic on port 8080 from app_alb"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.app_alb_sg.sg_id
  security_group_id = module.catalogue_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

# app_alb
# ---------
# should allow traffic on port 22 (for troubleshooting) from VPN (source - vpn)
# should allow traffic on port 80 from web.(source - web)
resource "aws_security_group_rule" "app_alb_from_vpn" {
  type              = "ingress"
  description       = "allowing traffic on port 22 (for troubleshooting) from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id #here source is vpn, so sg rules of vpn will be applicable to mongodb
  security_group_id = module.app_alb_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

resource "aws_security_group_rule" "app_alb_from_web" {
  type              = "ingress"
  description       = "allowing traffic on port 80 from web"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_sg.sg_id
  security_group_id = module.app_alb_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

# web
# ---
# should allow traffic on port 22 (for troubleshooting) from VPN (source - vpn)
# should allow traffic on port 80 from web_alb.(source - web_alb)
resource "aws_security_group_rule" "web_from_vpn" {
  type              = "ingress"
  description       = "allowing traffic on port 22 (for troubleshooting) from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id #here source is vpn, so sg rules of vpn will be applicable to mongodb
  security_group_id = module.web_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

resource "aws_security_group_rule" "web_from_web_alb" {
  type              = "ingress"
  description       = "allowing traffic on port 80 from web_alb"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.web_alb_sg.sg_id
  security_group_id = module.web_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

# web_alb
# -------
# should allow traffic on port 22(ssh)(for troubleshooting) from VPN (source - vpn)
# should allow traffic on port 443(https) from internet.(cidr_block - 0.0.0.0/0)
# should allow traffic on port 80(http) from internet.(cidr_block - 0.0.0.0/0)
resource "aws_security_group_rule" "web_alb_from_vpn" {
  type              = "ingress"
  description       = "allowing traffic on port 22 (for troubleshooting) from vpn"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn_sg.sg_id #here source is vpn, so sg rules of vpn will be applicable to mongodb
  security_group_id = module.web_alb_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

resource "aws_security_group_rule" "web_alb_from_internet_https" {
  type              = "ingress"
  description       = "allowing traffic on port 443 from web_alb"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  #we can either provide cidr_blocks or source_security_group_id, as it is from internet, we can provide cidr_blocks = ["0.0.0.0/0"] 
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}

resource "aws_security_group_rule" "web_alb_from_internet_http" {
  type              = "ingress"
  description       = "allowing traffic on port 80 from web_alb"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  #we can either provide cidr_blocks or source_security_group_id, as it is from internet, we can provide cidr_blocks = ["0.0.0.0/0"] 
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg.sg_id #sg_id is delcared in output variable in module and we store the same in parameter store.so we are fetching it here.
}