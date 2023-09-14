resource "aws_instance" "Instance-using-variables1"{
    ami = var.ami_id
    instance_type = var.instance_name == "Mongodb" ? "t3.micro" : "t2.micro"
    security_groups = [aws_security_group.allow_all_traffic.name]
    tags = var.tags
}

