# private load balancer (app_alb)
resource "aws_lb" "app_alb" {
   name               = "${var.project_name}-${var.common_tags.Component    }"
  internal           = true # as it is private alb, for public its false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.app_alb_sg_id.value]
  subnets            = split(",",data.aws_ssm_parameter.private_cidr_block.value)

  tags = var.common_tags
}

# alb_listener
resource "aws_lb_listener" "app_alb_listener" { 
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80" # as per sg_rule, app_alb allows traffic only on port 80
  protocol          = "HTTP" # as it is private instead if https
  
default_action {
    type = "fixed-response" #for now giving fixed response for testing purpose.

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}

# route 53 record to route from app-alb to all components like catalogue, user..etc
# if a request comes from user/api/catalogue, web nginx will direct it to catalogue component as per reverse proxy configuration
# but here the request needs to go thorugh app_alb and here load balancer decides to which instance traffic should go in that particular target group.(catlogue may have multiple instances and thery are group under catalogue target group)
module "r53_records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  zone_name = var.zone_name
  records = [
    {
      name    = "*app"
      type    = "A"
      alias   = {
        name    = aws_lb.app_alb.dns_name
        zone_id = aws_lb.app_alb.zone_id
      }

    },  
  ]
}

