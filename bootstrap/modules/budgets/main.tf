resource "aws_budgets_budget" "general" {
  name              = "budget-general-monthly"
  budget_type       = "COST"
  limit_amount      = "20"
  limit_unit        = "USD"
  time_period_start = "2025-08-01_00:00"
  time_period_end   = "2035-08-01_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 50
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [local.email]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [local.email]
    subscriber_sns_topic_arns  = [module.sns.sns_topic_arn]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 95
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [local.email]
    subscriber_sns_topic_arns  = [module.sns.sns_topic_arn]
  }

  tags = {
    Name        = "general-budget"
    Environment = "all"
    Purpose     = "cost-control"
  }
}