output "wordpress_vpc"{
	value = aws_vpc.wordpress_vpc.id
}
output "pubsub_id"{
	value = aws_subnet.pubsub[*].id
}
output "privsub_id"{
	value = aws_subnet.privsub[*].id
}
output "igw-wp"{
	value = aws_internet_gateway.igw-wp.id
}
output "dbsecuritygroup"{
	value = aws_security_group.dbsecuritygroup.id
}
output "dbsecuritygroup_name"{
	value = aws_security_group.dbsecuritygroup.name
}
output "albsecuritygroup"{
        value = aws_security_group.albsecuritygroup.id
}
output "albsecuritygroup_name"{
        value = aws_security_group.albsecuritygroup.name
}
output "ec2securitygroup"{
        value = aws_security_group.ec2securitygroup.id
}
output "ec2securitygroup_name"{
        value = aws_security_group.ec2securitygroup.name
}
