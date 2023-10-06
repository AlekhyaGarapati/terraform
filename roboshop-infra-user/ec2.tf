module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  for_each = var.instances
  name = each.key
  ami = data.aws_ami.ami_id.id # we are getting ami id dynamically from data source
  instance_type          = each.value
  vpc_security_group_ids = [local.allow_all_security_group_id]
  #subnet_id = each.key == "Web" ? local.public_cidr_block[0] : local.private_cidr_block[0] # public subnet in 1a az
  subnet_id = each.key == "Web" ? local.public_cidr_block[0] :((each.key == "MongoDB" || each.key == "MySQL" || each.key == "Redis" || each.key == "RabbitMQ" ) ? local.database_cidr_block[0] : local.private_cidr_block[0])
  #subnet_id = local.public_cidr_block[0]
tags = merge(
    {
        Name = each.key
    },
    var.common_tags
  )
}

module "ansible_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "ansible"
  ami = data.aws_ami.ami_id.id # we are getting ami id dynamically from data source
  instance_type          = "t2.micro"
  vpc_security_group_ids = [local.allow_all_security_group_id]
  subnet_id  = local.public_cidr_block[0]
  user_data = file("roboshop-ansible.sh")
tags = merge(
    {
        Name = "ansible"
    },
    var.common_tags
  )
}

