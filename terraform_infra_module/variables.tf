variable "cidr_block" {

}

variable "enable_dns_support" {
default = "true"
}

variable "enable_dns_hostnames" {
 default = "true"
}

variable "common_tags" {
type = map
default = {} # this indicates tags are optional
}

variable "vpc_tags" {
    type = map
    default = {}
}

variable "gw_tags" {
    type = map
    default = {}
}

variable "public_cidr_block"{

}
variable "azs"{

}

variable "public_subnet_names"{
    
}

variable "private_cidr_block"{

}
variable "private_subnet_names"{

}

variable "database_cidr_block"{

}
variable "database_subnet_names"{

}
variable "public_route_table_tags" {
    default = {} #optional
}

variable "private_route_table_tags" {
    default = {} #optional
}

variable "database_route_table_tags" {
    default = {} #optional
}

