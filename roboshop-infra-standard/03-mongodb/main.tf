module "mongodb" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "mongodb"
  ami = data.aws_ami.ami_id.id # we are getting ami id dynamically from data source
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.mongodb_sg_id.value]    
  # we are creating mongodb instance in roboshop vpc database subnet. 
  subnet_id  =  element(split(",",data.aws_ssm_parameter.database_cidr_block.value),0)
  user_data = file("mongodb.sh") # user_data will execute only at the time of instance creation, we cant apply user_data on instance which is already created
   tags = merge(
    {
        Name = "mongodb"
    },
    var.common_tags
  )
}   

module "r53_records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name
  records = [
    {
      name    = "mongodb"
      type    = "A"
      ttl     = 10
      records = [ 
        module.mongodb.private_ip
      ]
    },  
  ]
}
