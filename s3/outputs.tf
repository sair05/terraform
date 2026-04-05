output "bucket_arn" {
  description = "The ARN of the bucket"
  value       = aws_s3_bucket.my_bucket.arn
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}
