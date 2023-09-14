locals {
ami_id = "ami-03265a0778a880afb"
instance_type = var.isPROD ? "t3.medium" : "t2.micro"
pub_key = file("${path.module}/devops.pub")
}

