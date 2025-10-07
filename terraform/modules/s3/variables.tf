variable "bucket_name" {
  type        = string
}

variable "force_destroy" {
  type        = bool
  default     = true
}

variable "cloudfront_distribution_arn" {
  type        = string
}
