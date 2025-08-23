variable "porkbun_api_key" {
  type        = string
  sensitive   = true
}

variable "porkbun_secret_api_key" {
  type        = string
  sensitive   = true
}

variable "domain_name" {
  type    = string
  default = "seagram.dev"
}

variable "domain_aliases" {
  type    = list(string)
  default = ["www.seagram.dev"]
}

variable "website_bucket_name" {
  type    = string
  default = "seagram-bucket"
}