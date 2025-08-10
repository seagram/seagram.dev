variable "root_domain_name" {
  type = string
}

variable "domain_aliases" {
  type = list(string)
}

variable "s3_bucket_regional_domain_name" {
  type = string
}

variable "acm_certificate_arn" {
  type = string
}