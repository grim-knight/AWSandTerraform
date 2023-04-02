output "dns_name"{
	value = aws_lb.tf-alb.dns_name
}

output "zone_id"{
	value = aws_lb.tf-alb.zone_id
}
