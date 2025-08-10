variable "phone_number" {
  description = "Phone number for SNS budget alerts"
  type        = string
  sensitive   = true
}

variable "email" {
  description = "Email address for SNS budget alerts"
  type        = string
  sensitive   = true
}