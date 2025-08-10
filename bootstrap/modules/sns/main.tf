resource "aws_sns_topic" "budget_alerts" {
  name         = "general-budget-alerts"
  display_name = "General Budget Notifications"
  tags = {
    Name        = "general-budget-alerts-topic"
    Environment = "all"
    Purpose     = "budget-notifications"
  }
}

resource "aws_sns_topic_subscription" "budget_sms" {
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "sms"
  endpoint  = local.phone_number
}

resource "aws_sns_topic_subscription" "budget_email" {
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "email"
  endpoint  = local.email
}
