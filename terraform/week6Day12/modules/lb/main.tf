resource "aws_eip" "tf-eip"{
	vpc = true
}

#create an ALB with target group and listners
resource "aws_lb" "tf-alb"{
	name = "tf-lb"
	internal = false
	load_balancer_type = "network"
	security_groups = [var.albsecuritygroup]
	depends_on = [aws_eip.tf-eip]
	subnet_mapping {
		subnet_id = var.pubsub_id[0]
		allocation_id = aws_eip.tf-eip.id
	}
	subnet_mapping {
                subnet_id = var.pubsub_id[1]
                allocation_id = aws_eip.tf-eip.id
        }
}

resource "aws_lb_target_group" "targetgrouplb"{
	name = "targetgrouplb"
	port = "80"
	#target_type = "instance"
	protocol = "HTTP"
	vpc_id = var.wordpress_vpc
	health_check {
    		path = "/"
    	#	port = 80
    		protocol = "HTTP"
    		interval = 60
    		timeout = 30
  }
  
  # Register the EC2 instances with the target group
  	lifecycle {
    		create_before_destroy = true
  	}

}


resource "aws_lb_listener" "listnerlb"{
	load_balancer_arn = aws_lb.tf-alb.arn
	port = "80"
	protocol = "HTTP"
	ssl_policy = "ELBSecurityPolicy-2016-08"
	certificate_arn = var.certificate_arn
	default_action {
		type = "forward"
		target_group_arn = aws_lb_target_group.targetgrouplb.arn
	}
}

resource "aws_lb_target_group_attachment" "i1" {
  count = length(var.instance_id) == 2 ? 2 : 0
  target_group_arn = aws_lb_target_group.targetgrouplb.arn
  target_id        = var.instance_id[count.index]
#  port             = 80
}
