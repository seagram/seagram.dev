variable "porkbun_api_key" {
  description = "Porkbun API key"
  type        = string
  sensitive   = true
}

variable "porkbun_secret_api_key" {
  description = "Porkbun secret API key"
  type        = string
  sensitive   = true
}

variable "root_domain_name" {
  type        = string
  description = "The root domain name."
}

variable "domain_aliases" {
  type        = list(string)
  description = "A list of domain aliases."
}

variable "zone_id" {
  type        = string
  description = "The ID of the Route53 zone."
}


variable "s3_bucket_regional_domain_name" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}


variable "route53_zone_name_servers" {
  type = list(string)
}

variable "cloudfront_distribution_domain_name" {
  type = string
}

variable "cloudfront_distribution_hosted_zone_id" {
  type = string
}

variable "bucketname" {
  type = string
}

