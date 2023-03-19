resource "aws_db_instance" "dbinstance"{
	allocated_storage = 10
	db_name = var.db_name
	engine = var.db_engine
	instance_class = var.db_instanceclass
	username = var.db_name
	password = var.db_pass
	availability_zone = "us-east-1a"
	publicly_accessible = true
	db_subnet_group_name = aws_db_subnet_group.dbsubgroup.name
	vpc_security_group_ids = [var.dbsecuritygroup]
	skip_final_snapshot = true
}

resource "aws_db_subnet_group" "dbsubgroup"{
	subnet_ids = var.privsub_id[*]
}
