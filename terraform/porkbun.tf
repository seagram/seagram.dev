resource "porkbun_nameservers" "nameservers" {
  domain      = var.root_domain_name
  nameservers = aws_route53_zone.zone.name_servers
}
