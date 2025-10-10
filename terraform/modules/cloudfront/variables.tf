variable "root_domain_name" {
  type        = string
}

variable "domain_aliases" {
  type        = list(string)
  default     = []
}

variable "s3_bucket_regional_domain_name" {
  type        = string
}

variable "acm_certificate_arn" {
  type        = string
}

variable "default_root_object" {
  type        = string
  default     = "index.html"
}

variable "price_class" {
  type        = string
  default     = "PriceClass_All"
}

variable "logging_bucket" {
  type        = string
  description = "S3 bucket domain name for CloudFront access logs (e.g., bucket-name.s3.amazonaws.com)"
  default     = ""
}

variable "logging_prefix" {
  type        = string
  description = "Prefix for CloudFront log files in S3"
  default     = "cloudfront-logs/"
}
