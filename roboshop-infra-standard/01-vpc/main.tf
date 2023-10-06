module roboshop_infra_advanced {
 source = "../../terraform-aws-vpc-advanced"
 cidr_block = var.cidr_block
 common_tags = var.common_tags
 project_name = var.project_name
 public_cidr_block = var.public_cidr_block
 private_cidr_block = var.private_cidr_block
 database_cidr_block = var.database_cidr_block

 #Peering
 is_peering_required = var.is_peering_required
 default_vpc_id = data.aws_vpc.default_vpc.id
 default_route_table_id = data.aws_vpc.default_vpc.main_route_table_id
 default_cidr_block = data.aws_vpc.default_vpc.cidr_block
 }
