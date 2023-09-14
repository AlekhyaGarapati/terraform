resource "aws_instance" "referring-locals"{
    ami = local.ami_id
    instance_type = local.instance_type
    key_name = aws_key_pair.devopskey-pair.key_name
    tags = {
        Name = "locals-testing"
    }
    }


resource "aws_key_pair" "devopskey-pair" {
  key_name   = "devops.pub"
  public_key = local.pub_key
}


