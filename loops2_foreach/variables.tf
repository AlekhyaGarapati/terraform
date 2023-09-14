variable "ami_id" {
  default = "ami-03265a0778a880afb"
}

variable "instances" {
  type = map
  default = {
    MongoDB = "t3.medium"
    MySQL = "t3.medium"
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

variable "zone_id" {
    type = string
    default = "Z07719251CXO88RVYQRQR"
}

variable "domain_name" {
    type = string
    default = "robokart.online"
}
