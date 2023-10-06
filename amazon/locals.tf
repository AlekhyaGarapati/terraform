locals {
    vpc_id = module.roboshop_infra_advanced.vpc_id
    public_cidr_block = module.roboshop_infra_advanced.public_cidr_block
    private_cidr_block = module.roboshop_infra_advanced.private_cidr_block
    database_cidr_block = module.roboshop_infra_advanced.database_cidr_block
    
}