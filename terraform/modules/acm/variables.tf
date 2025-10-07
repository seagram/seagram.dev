variable "root_domain_name" {
  type        = string
}

variable "domain_aliases" {
  type        = list(string)
  default     = []
}

variable "zone_id" {
  type        = string
}
