# Budgets
resource "aws_budgets_budget" "budget" {
  name              = "seagram.dev-budget"
  budget_type       = "COST"
  limit_amount      = "10"
  limit_unit        = "USD"
  time_period_end   = "2030-01-01_00:00"
  time_period_start = "2024-01-01_00:00"
  time_unit         = "ANNUALLY"
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.budget_notification_email]
  }
}
