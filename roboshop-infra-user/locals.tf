locals {
    vpc_id = module.roboshop_infra_advanced.vpc_id
    public_cidr_block = module.roboshop_infra_advanced.public_cidr_block
    private_cidr_block = module.roboshop_infra_advanced.private_cidr_block
    database_cidr_block = module.roboshop_infra_advanced.database_cidr_block
    allow_all_security_group_id = module.allow_all_sg.sg_id
    instance_info = module.ec2_instance # getting all output parameters from instance. later we will fetch eith public or private ip based on component
    
}