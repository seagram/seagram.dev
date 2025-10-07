output "main_record_fqdn" {
  value       = aws_route53_record.main_record.fqdn
}

output "alias_record_fqdns" {
  value       = [for r in aws_route53_record.alias_record : r.fqdn]
}
