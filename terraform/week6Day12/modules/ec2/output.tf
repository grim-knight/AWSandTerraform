output "instance_id"{
	value = aws_instance.wp-ec2[*].id
}
