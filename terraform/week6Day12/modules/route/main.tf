resource "aws_route53_zone" "route-wp"{
	name = "tfwordpress.com"
}

# Create an AWS ACM certificate
resource "aws_acm_certificate" "tfwordpress" {
  domain_name       = "tfwordpress.com"
  validation_method = "DNS"
}


#First comment the resource "aws_route53_record" "validation", resource "aws_acm_certificate_validation" "tfwordpress" and run the code once done then uncomment these reosurces and run again.
# Create a validation record in Route 53
#resource "aws_route53_record" "validation" {
#  for_each = {
#    for option in aws_acm_certificate.tfwordpress.domain_validation_options : option.resource_record_name => option
#  }
#  zone_id = aws_route53_zone.route-wp.zone_id
#  name    = each.value.resource_record_name
#  type    = each.value.resource_record_type
#  records = [each.value.resource_record_value]
#}

# Wait for the certificate to be issued
#resource "aws_acm_certificate_validation" "tfwordpress" {
#  certificate_arn = aws_acm_certificate.tfwordpress.arn
#  validation_record_fqdns = [for i in aws_route53_record.validation : i.fqdn]
#  depends_on = [aws_route53_record.validation]
#}

resource "aws_route53_record" "record-wp"{
	zone_id = aws_route53_zone.route-wp.zone_id
	name = "tfwordpress.com"
	type = "CNAME"

	alias{
		name = var.dns_name
		zone_id =var.zone_id
		evaluate_target_health = true
	}
}
