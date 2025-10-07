variable "aws_region" {
  type        = string
}

variable "root_domain_name" {
  type        = string
}

variable "domain_aliases" {
  type        = list(string)
}

variable "bucket_name" {
  type        = string
}

variable "porkbun_api_key" {
  type        = string
  sensitive   = true
}

variable "porkbun_secret_api_key" {
  type        = string
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  default     = {}
}