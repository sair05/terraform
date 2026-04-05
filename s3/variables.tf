variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to the resource"
  type        = map(string)
  default     = {
    Environment = "Dev"
    Project     = "Learning"
  }
}
