variable "ami_id" {
    type = string
    default = "ami-03265a0778a880afb"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "sg_name" {
    type = string
    default = "allow_all"
}

variable "sg_desc" {
    type = string
    default = "Allow all traffic via Terraform"
}

variable "from_port" {
    type = number
    default = 0
}

variable "to_port" {
    type = number
    default = 0
}

variable "cidr_blocks" {
  type = list
  default = ["0.0.0.0/0"] 
}

variable "tags" {
    type = map
    default = {
      Name = "Mongodb"
      Environment = "Dev"
      Terraform = "true"
      Project = "Roboshop"
      Component = "Mongodb"
    }
}

variable "newtags" {
    type = map
    default = {
      Name = "newMongodb"
      Environment = "Dev"
      Terraform = "true"
      Project = "Roboshop"
      Component = "Mongodb"
    }
}