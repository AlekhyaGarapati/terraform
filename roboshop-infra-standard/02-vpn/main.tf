 module "vpn_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "vpn"
  ami = data.aws_ami.ami_id.id # we are getting ami id dynamically from data source
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.vpn_sg_id.value]
  # we are creating vpn instance in default vpc default subnet. if we dont provide any subnet value by default it will be installed in default subnet
  #subnet_id  = local.public_cidr_block[0]
tags = merge(
    {
        Name = "vpn"   
    },
    var.common_tags
  )
}

