variable "zone_id" {
  type = string
}

variable "cloudfront_distribution_domain_name" {
  type = string
}

variable "cloudfront_distribution_hosted_zone_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "domain_aliases" {
  type = list(string)
}