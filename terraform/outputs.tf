output "cloudfront_domain_name" {
  description = "Public URL host of the portfolio"
  value       = aws_cloudfront_distribution.site.domain_name
}

output "distribution_id" {
  description = "Used for cache invalidations"
  value       = aws_cloudfront_distribution.site.id
}

output "bucket_name" {
  value = aws_s3_bucket.site.id
}

output "deploy_role_arn" {
  description = "Role the GitHub workflow assumes"
  value       = aws_iam_role.github_deploy.arn
}
