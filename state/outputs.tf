output "backend_config" {
  description = "Backend config to use for other Terraform projects"
  value = {
    bucket         = aws_s3_bucket.bucket.id
    dynamodb_table = aws_dynamodb_table.table.name
  }
}
