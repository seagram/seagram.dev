variable "name_prefix" {
  type        = string
  default     = ""
}

variable "secrets" {
  type = map(object({
    value       = string
    description = string
  }))
}

variable "recovery_window_in_days" {
  type        = number
  default     = 30
}

variable "tags" {
  type        = map(string)
  default     = {}
}
