variable "project_name" {
    default = "roboshop"
}

variable "env" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Environment = "dev"
        Component = "vpc"
        Terraform = "true"
        Project = "roboshop"
    }
}