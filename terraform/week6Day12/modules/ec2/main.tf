resource "aws_instance" "wp-ec2"{
	count = length(var.pubsub_id)
	ami = "ami-0aa7d40eeae50c9a9"
	instance_type = "t2.micro"
	associate_public_ip_address = true
	key_name = "sagartest"
	vpc_security_group_ids = ["${var.ec2securitygroup}"]
	subnet_id = var.pubsub_id[count.index]
	
	depends_on = [var.ec2securitygroup]

	user_data = <<EOF
		#!/bin/bash
    		sudo yum install -y httpd php php-mysql mysql-server
    		sudo wget https://wordpress.org/wordpress-5.1.1.tar.gz
    		sudo tar -xzf wordpress-5.1.1.tar.gz -C /home/ec2-user/
    		sudo chmod -R 755 /var/www/html/wp-content
    		sudo chown -R apache:apache /var/www/html/wp-content
		sudo rsync -avh  wordpress/* /var/www/html/
    		sudo systemctl start httpd
    		sudo systemctl enable httpd
		EOF
	tags = {
		Name = "wp-ec2"
	}
}

output "public_ip_address"{
	value = aws_instance.wp-ec2[*].public_ip
}
