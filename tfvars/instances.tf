resource "aws_instance" "roboshop" {
    ami = var.ami_id
    for_each = var.instances
    instance_type = each.value
    tags = {
        Name = each.key
    }
}

resource "aws_route53_record" "route53" {
  zone_id = var.zone_id
  for_each = aws_instance.roboshop # the above block will give output of all values created while creating instance.
  name    = "${each.key}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [each.key == "Web" ? each.value.public_ip : each.value.private_ip]
}

resource "aws_security_group" "allow_all_traffic" {
  name = var.sg_name
  description = var.sg_desc

  ingress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }


  egress {
    from_port   = var.from_port
    to_port     = var.to_port
    protocol    = "-1" # allows protocols 
    cidr_blocks = var.cidr_blocks
  } 
}