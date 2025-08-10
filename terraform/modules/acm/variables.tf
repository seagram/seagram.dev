variable "root_domain_name" {
  type = string
  description = "The root domain name."
}

variable "domain_aliases" {
  type = list(string)
  description = "A list of domain aliases."
}

variable "zone_id" {
  type = string
  description = "The ID of the Route53 zone."
}