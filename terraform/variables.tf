variable "region" {
  description = "AWS region for the bucket and provider"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique name for the portfolio S3 bucket"
  type        = string
  default     = "muzi-portfolio-tf-001"
}

variable "github_repo" {
  description = "GitHub repository allowed to deploy, as owner/name"
  type        = string
  default     = "muzi288/aws-portfolio-site"
}
