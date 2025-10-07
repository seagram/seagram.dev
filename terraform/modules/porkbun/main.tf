resource "porkbun_nameservers" "nameservers" {
  domain      = var.domain_name
  nameservers = var.nameservers
}
