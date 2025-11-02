output "topic_arn" {
  value = aws_sns_topic.budget_alerts.arn
}

output "topic_name" {
  value = aws_sns_topic.budget_alerts.name
}
