resource "aws_s3_bucket" "site" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Site content is now deployed by the GitHub Actions pipeline.
# Terraform stops tracking the object but must not delete it.
removed {
  from = aws_s3_object.index

  lifecycle {
    destroy = false
  }
}
