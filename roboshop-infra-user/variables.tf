variable "cidr_block" {
    default = "10.0.0.0/16"
}

variable "common_tags" {
    default = {
        Environment = "dev"
        Terraform = "true"
        Project = "roboshop"
    }
}

variable "project_name" {
    default = "roboshop"
}

variable "public_cidr_block" {
    default = ["10.0.1.0/24","10.0.2.0/24"]
}

variable "private_cidr_block" {
    default = ["10.0.11.0/24","10.0.12.0/24"]
}

variable "database_cidr_block" {
    default = ["10.0.21.0/24","10.0.22.0/24"]
}

variable "sg_name" {
    default = "allow_all"
}

variable "sg_description" {
    default = "Allowing all security group"
}

variable "sg_ingress_rules" {
    default = [ 
        {
        description = "Allowing all"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
       }       
    ]
        
}

variable "instances" {
  default = {
    MongoDB = "t2.micro"
    MySQL = "t2.micro"
    Redis = "t2.micro"
    RabbitMQ = "t2.micro"
    Catalogue = "t2.micro"
    User = "t2.micro"
    Cart = "t2.micro"
    Shipping = "t2.micro"
    Payment = "t2.micro"
    Web = "t2.micro"
  }
}

variable "zone_name" {
    default = "robokart.online"
}

variable "is_peering_required" {
    default = "true"
}

