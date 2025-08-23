output "zone_id" {
  value = aws_route53.zone.zone_id
}

output "zone_name_servers" {
  value = aws_route53.zone.name_servers
}