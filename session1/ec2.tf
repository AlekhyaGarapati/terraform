resource "aws_instance" "Instance-using-variables"{
    ami = var.ami_id
    instance_type = var.instance_type
    security_groups = [aws_security_group.allow_all_traffic.name]
    tags = var.tags
}

