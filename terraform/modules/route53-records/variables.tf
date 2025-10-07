variable "zone_id" {
  type        = string
}

variable "root_domain_name" {
  type        = string
}

variable "domain_aliases" {
  type        = list(string)
  default     = []
}

variable "cloudfront_distribution_domain_name" {
  type        = string
}

variable "cloudfront_distribution_hosted_zone_id" {
  type        = string
}

variable "enable_spf_record" {
  type        = bool
  default     = true
}
