variable "bucketname" {
  default = "seagram-bucket"
}

variable "root_domain_name" {
  type    = string
  default = "seagram.dev"
}

variable "domain_aliases" {
  type = list(string)
  default = [
    "www.seagram.dev"
  ]
}

variable "budget_notification_email" {
  description = "Email for Budget Notifications"
  type        = string
  sensitive   = true
}

variable "porkbun_api_key" {
  description = "Porkbun API Key"
  type        = string
  sensitive   = true
}

variable "porkbun_secret_api_key" {
  description = "Porkbun Secret API Key"
  type        = string
  sensitive   = true
}

