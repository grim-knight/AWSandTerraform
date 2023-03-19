resource "aws_route53_zone" "route-wp"{
	name = "tfwordpress.com"
}

resource "aws_route53_record" "record-wp"{
	zone_id = aws_route53_zone.route-wp.zone_id
	name = "tfwordpress.com"
	type = "A"
	alias{
		name = var.dns_name
		zone_id =var.zone_id
		evaluate_target_health = true
	}
}
