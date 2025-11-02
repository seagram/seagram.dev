variable "tags" {
  type    = map(string)
  default = {}
}

variable "budget_alert_email" {
  type    = string
  default = "seagramdev@gmail.com"
}

variable "monthly_budget_limit" {
  type    = string
  default = "10"
}

variable "budget_alarm_threshold" {
  type    = number
  default = 6
}
