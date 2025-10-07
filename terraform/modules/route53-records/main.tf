resource "aws_route53_record" "main_record" {
  zone_id = var.zone_id
  name    = var.root_domain_name
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alias_record" {
  count   = length(var.domain_aliases)
  zone_id = var.zone_id
  name    = var.domain_aliases[count.index]
  type    = "A"

  alias {
    name                   = var.cloudfront_distribution_domain_name
    zone_id                = var.cloudfront_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "spf_txt" {
  count   = var.enable_spf_record ? 1 : 0
  zone_id = var.zone_id
  name    = var.root_domain_name
  type    = "TXT"
  ttl     = 300
  records = ["v=spf1 mx include:_spf.porkbun.com ~all"]
}
