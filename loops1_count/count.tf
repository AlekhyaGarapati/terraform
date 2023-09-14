resource "aws_instance" "loops-using-count"{
    ami = var.ami_id
    count = 10
    instance_type = "t2.micro"
   # instance_type = var.instance_names[count.index] == "mongodb" || var.instance_names[count.index]== "mysql" ? "t3.medium" : "t2.micro"
    tags = {
        Name = var.instance_names[count.index]
    }
}

resource "aws_route53_record" "route53" {
  count = 10
  zone_id = var.zone_id
  name    = "${var.instance_names[count.index]}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = [var.instance_names[count.index] == "web" ? aws_instance.loops-using-count[count.index].public_ip : aws_instance.loops-using-count[count.index].private_ip]
}

resource "aws_instance" "Instance-using-keypair"{
    ami = var.ami_id
    instance_type = "t2.micro"
    key_name = aws_key_pair.devopskey-pair.key_name
    tags = {
        Name = "deleteMe"
    }
    }


resource "aws_key_pair" "devopskey-pair" {
  key_name   = "devops.pub"
  public_key = file("${path.module}/devops.pub")
}


