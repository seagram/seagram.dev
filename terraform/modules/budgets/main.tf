resource "aws_budgets_budget" "monthly_cost" {
  name              = "${var.project_name}-monthly-budget"
  budget_type       = "COST"
  limit_amount      = var.monthly_budget_limit
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2025-11-01_00:00"

  cost_filter {
    name = "TagKeyValue"
    values = [
      "user:Project$${var.project_name}",
    ]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_sns_topic_arns  = [var.sns_topic_arn]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_sns_topic_arns  = [var.sns_topic_arn]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 90
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_sns_topic_arns  = [var.sns_topic_arn]
  }
}

resource "aws_cloudwatch_metric_alarm" "estimated_charges" {
  alarm_name          = "${var.project_name}-estimated-charges"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = 21600 # 6 hours
  statistic           = "Maximum"
  threshold           = var.alarm_threshold
  alarm_description   = "Alert when estimated charges exceed threshold"
  alarm_actions       = [var.sns_topic_arn]

  dimensions = {
    Currency = "USD"
  }
}
