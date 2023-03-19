#create an ALB with target group and listners
resource "aws_lb" "tf-alb"{
	name = "tf-lb"
	internal = false
	load_balancer_type = "application"
	security_groups = [var.albsecuritygroup]
	subnets = var.pubsub_id
	
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
