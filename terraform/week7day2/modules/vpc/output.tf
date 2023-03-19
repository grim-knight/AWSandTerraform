output "new_vpc" {
	value = aws_vpc.new_vpc.id
}

output "tf-subnet-public"{
	value = aws_subnet.tf-subnet-public.id
}
