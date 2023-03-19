#VPC resource
resource "aws_vpc" "wordpress_vpc"{
	cidr_block = var.vpc_cidr
}

#Public subnet
resource "aws_subnet" "pubsub"{
	vpc_id = aws_vpc.wordpress_vpc.id
	count = length(var.azs)
	availability_zone = var.azs[count.index]
	map_public_ip_on_launch = true
	cidr_block = var.pubsubCIDRblock[count.index]
}
#Private subnet
resource "aws_subnet" "privsub"{
        vpc_id = aws_vpc.wordpress_vpc.id
        count = length(var.azs)
        availability_zone = var.azs[count.index]
        map_public_ip_on_launch = true
        cidr_block = var.privsubCIDRblock[count.index]
}

#igw-wp
resource "aws_internet_gateway" "igw-wp"{
        vpc_id = aws_vpc.wordpress_vpc.id
        tags = {
                Name = "wordpress-igw"
        }
}

resource "aws_route_table" "rt-wp"{
	vpc_id = aws_vpc.wordpress_vpc.id
	route{
		cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.igw-wp.id
	}
}



resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.pubsub[0].id
  route_table_id = aws_route_table.rt-wp.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.pubsub[1].id
  route_table_id = aws_route_table.rt-wp.id
}


#sg db
resource "aws_security_group" "dbsecuritygroup"{
	description = "Security group for db instance"
	vpc_id = aws_vpc.wordpress_vpc.id
	ingress {
		from_port = 3306
		to_port = 3306
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	egress{
		from_port = 0
		to_port = 0
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
		Name = "dbsecuritygroup"
	}
}
#sg alb
# Security group for ALB
resource "aws_security_group" "albsecuritygroup" {
  description = "Security group for ALB"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [aws_security_group.ec2securitygroup.id]
  }


  tags = {
    Name = "albsecuritygroup"
  }
}

# Security group for EC2
resource "aws_security_group" "ec2securitygroup" {
  description = "Security group for EC2"
  vpc_id      = aws_vpc.wordpress_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["70.120.100.125/32", "24.242.173.10/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.albsecuritygroup.id]
  }

   ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.albsecuritygroup.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2securitygroup"
  }
}

# Ingress rule allowing HTTP traffic from the ALB security group
#resource "aws_security_group_rule" "http_from_alb" {
#  type              = "ingress"
#  from_port         = 80
#  to_port           = 80
#  protocol          = "tcp"
#  security_group_id = aws_security_group.ec2securitygroup.id
#  source_security_group_id = aws_security_group.albsecuritygroup.id
#}

