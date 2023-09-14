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