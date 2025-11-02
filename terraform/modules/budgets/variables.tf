variable "project_name" {
  type = string
}

variable "monthly_budget_limit" {
  type    = string
  default = "10"
}

variable "alarm_threshold" {
  type    = number
  default = 8
}

variable "sns_topic_arn" {
  type = string
}
