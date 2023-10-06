variable "project_name" {
    default = "roboshop"
}

variable "sg_name" {
    default = "mongodb_sg"
}

variable "sg_description" {
    default = "Allowing traffic only from VPN securty group"
}

variable "common_tags" {
    default = {
        Environment = "dev"
        Component = "mongodb"
        Terraform = "true"
        Project = "roboshop"
    }
}

variable "env" {
    default = "dev"
}

variable "zone_name" {
    default = "robokart.online"
}