provider "aws"{
	region = "us-east-1"
}

provider "aws"{
	alias = "reg2"
	region = "us-east-2"
}

resource "aws_vpc" "vpc1"{
	cidr_block = "10.0.0.0/16"
	tags = {
		Name = "peer_vpc_1"
	}
}

resource "aws_vpc" "vpc2"{
	provider = aws.reg2
	cidr_block = "10.1.0.0/16"
	tags = {
		Name = "peer_vpc_2"
	}
}

data "aws_caller_identity" "owner" {
	provider = aws
}

#requester's side of connection
resource "aws_vpc_peering_connection" "peer"{
	vpc_id = aws_vpc.vpc1.id
	peer_vpc_id = aws_vpc.vpc2.id
	peer_owner_id = data.aws_caller_identity.owner.account_id
	peer_region = "us-east-2"
	auto_accept = false
}

#accepter's side of connection
resource "aws_vpc_peering_connection_accepter" "peering"{
	provider = aws.reg2
	vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
	auto_accept = true
}
