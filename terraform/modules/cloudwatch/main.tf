resource "aws_cloudwatch_dashboard" "analytics" {
  dashboard_name = "${var.domain_name}-analytics"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/CloudFront", "Requests", { stat = "Sum", label = "Total Requests", region = "us-east-1" }]
          ]
          period = 86400
          stat   = "Sum"
          region = "us-east-1"
          title  = "Daily Requests"
          view   = "timeSeries"
          yAxis = {
            left = {
              min = 0
            }
          }
        }
        width  = 12
        height = 6
        x      = 0
        y      = 0
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/CloudFront", "BytesDownloaded", { stat = "Sum", label = "Bytes Downloaded", region = "us-east-1" }],
            [".", "BytesUploaded", { stat = "Sum", label = "Bytes Uploaded", region = "us-east-1" }]
          ]
          period = 86400
          stat   = "Sum"
          region = "us-east-1"
          title  = "Data Transfer"
          view   = "timeSeries"
        }
        width  = 12
        height = 6
        x      = 0
        y      = 6
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/CloudFront", "4xxErrorRate", { stat = "Average", label = "4xx Errors", region = "us-east-1" }],
            [".", "5xxErrorRate", { stat = "Average", label = "5xx Errors", region = "us-east-1" }]
          ]
          period = 86400
          stat   = "Average"
          region = "us-east-1"
          title  = "Error Rates"
          yAxis = {
            left = {
              min = 0
              max = 100
            }
          }
        }
        width  = 12
        height = 6
        x      = 0
        y      = 12
      }
    ]
  })
}
