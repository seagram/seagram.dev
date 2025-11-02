output "budget_name" {
  value = aws_budgets_budget.monthly_cost.name
}

output "alarm_arn" {
  value = aws_cloudwatch_metric_alarm.estimated_charges.arn
}
