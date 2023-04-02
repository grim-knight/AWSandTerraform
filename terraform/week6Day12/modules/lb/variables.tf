variable "instance_id"{
	type = list
}
variable "albsecuritygroup"{
	type = string
}

variable "pubsub_id"{
	type = list
}
variable "listenport"{
	type = string
}

variable "listenprotocol"{
	type = string
}

variable "wordpress_vpc"{
	type =string
}
variable "igw-wp"{
	type = string
}

variable "certificate_arn"{
	type = string
}
