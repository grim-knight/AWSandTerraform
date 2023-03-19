resource "aws_route53_record" "webbucketDomain-a" {
  zone_id = "/hostedzone/Z0888322T32EYIWXPCH5"
  name    = var.domainName
  type    = "A"
  alias {
    name                   = aws_s3_bucket.webbucket.website_endpoint
    zone_id                = aws_s3_bucket.webbucket.hosted_zone_id
    evaluate_target_health = true
  }
}
