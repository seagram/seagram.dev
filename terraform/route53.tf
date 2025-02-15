resource "aws_route53_zone" "zone" {
  name = var.root_domain_name
}

resource "aws_route53_record" "main-record" {
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.root_domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias-record" {
  count   = length(var.domain_aliases)
  zone_id = aws_route53_zone.zone.zone_id
  name    = var.domain_aliases[count.index]
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}