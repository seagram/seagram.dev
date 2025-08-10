terraform {
  required_providers {
    porkbun = {
      source  = "kyswtn/porkbun"
      version = "0.1.3"
    }
  }
}

resource "porkbun_nameservers" "nameservers" {
  domain      = var.root_domain_name
  nameservers = var.route53_zone_name_servers
}