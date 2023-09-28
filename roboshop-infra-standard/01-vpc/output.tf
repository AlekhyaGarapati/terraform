output "vpc_id" {
    value = module.roboshop_infra_advanced.vpc_id #module.<module-name>.<outputvariable-name>
}


output "public_cidr_block" {
    value = module.roboshop_infra_advanced.public_cidr_block
}

output "private_cidr_block" {
    value = module.roboshop_infra_advanced.private_cidr_block
}

output "database_cidr_block" {
    value = module.roboshop_infra_advanced.database_cidr_block
}





