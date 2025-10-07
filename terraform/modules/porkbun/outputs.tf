output "domain" {
  value       = porkbun_nameservers.nameservers.domain
}

output "nameservers" {
  value       = porkbun_nameservers.nameservers.nameservers
}
