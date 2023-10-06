module roboshop_infra {
 source = "../terraform_infra_module"
 cidr_block = var.cidr_block
 common_tags = var.common_tags

 #Internet gateway
 vpc_tags = var.vpc_tags
 gw_tags = var.gw_tags

 #Subnet - public, private, database
 public_cidr_block = var.public_cidr_block
 azs = var.azs
 public_subnet_names = var.public_subnet_names

 private_cidr_block = var.private_cidr_block
 private_subnet_names = var.private_subnet_names

 database_cidr_block = var.database_cidr_block
 database_subnet_names = var.database_subnet_names

public_route_table_tags = var.public_route_table_tags
private_route_table_tags = var.private_route_table_tags
database_route_table_tags = var.database_route_table_tags
} 

