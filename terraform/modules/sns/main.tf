resource "aws_sns_topic" "budget_alerts" {
  name         = "${var.project_name}-budget-alerts"
  display_name = "Budget alerts for ${var.project_name}"
}

resource "aws_sns_topic_subscription" "budget_email" {
  topic_arn = aws_sns_topic.budget_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}
