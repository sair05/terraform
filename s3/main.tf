resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
  tags   = var.tags
}

# Optional: Add ownership controls (standard practice)
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.my_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
