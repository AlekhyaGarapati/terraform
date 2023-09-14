resource "aws_security_group" "dynamicpractice" {
    name = "dynamic-allow"
    description = "allows SSH, HTTP, and HTTPS ports"
    
    dynamic ingress {
    for_each = var.inboundrules 
    content {
    description = ingress.value["description"]  # we have to refer ingress.value['attribute'] 
    from_port = ingress.value["from_port"]
	to_port = ingress.value["to_port"]
	protocol = ingress.value["protocol"]
	cidr_blocks = ingress.value["cidr_blocks"]
            }
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # allows protocols 
    cidr_blocks = ["0.0.0.0/0"]
  } 

}