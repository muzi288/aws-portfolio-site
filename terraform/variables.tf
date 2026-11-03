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

variable "github_subject" {
  description = "Exact OIDC subject GitHub sends for the deploy workflow (includes numeric owner and repo IDs)"
  type        = string
  default     = "repo:muzi288@70324548/aws-portfolio-site@1437461895:ref:refs/heads/main"
}
