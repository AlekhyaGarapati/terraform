variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "common_tags" {
    type = map
    default = {
        Environment = "dev"
        Terraform = "true"
        Project = "roboshop"
    }
}
#Internet gateway Variables
variable "vpc_tags" {
    type = map
    default = {
        Name = "roboshop_network"
    }
}

variable "gw_tags" {
    type = map
    default = {
        Name = "roboshop_vpc_gateway"
    }
}

# subnet Variables - public, private, database
variable "azs" {
    default = ["us-east-1a","us-east-1b"]
}
variable "public_cidr_block" {
    default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "public_subnet_names" {
    default = ["roboshop_public_1a","roboshop_public_1b"]
}

variable "private_cidr_block" {
    default = ["10.0.11.0/24","10.0.12.0/24"]
}

variable "private_subnet_names" {
    default = ["roboshop_private_1a","roboshop_private_1b"]
}

variable "database_cidr_block" {
    default = ["10.0.21.0/24","10.0.22.0/24"]
}

variable "database_subnet_names" {
    default = ["roboshop_database_1a","roboshop_database_1b"]
}
variable "public_route_table_tags" {
    default = {
      Name = "public_route_table"
    }
}

variable "private_route_table_tags" {
    default = {
      Name = "private_route_table"
    }
}

variable "database_route_table_tags" {
    default = {
      Name = "database_route_table"
    }
}