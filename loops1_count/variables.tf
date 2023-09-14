variable "ami_id" {
    type = string
    default = "ami-03265a0778a880afb"
}

variable "instance_names" {
    type = list
    default = ["mongodb", "redis", "mysql", "rabbitmq", "catalogue", "user", "cart", "shipping", "payment", "web"]
}

variable "zone_id" {
    type = string
    default = "Z07719251CXO88RVYQRQR"
}

variable "domain_name" {
    type = string
    default = "robokart.online"
}


variable "isPROD" {
  default = false
}