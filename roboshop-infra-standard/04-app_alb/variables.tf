variable "project_name" {
    default = "roboshop"
}

variable "common_tags" {
    default = {
        Environment = "dev"
        Component = "app-alb"
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