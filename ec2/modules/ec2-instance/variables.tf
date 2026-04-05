variable "ami_id" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-01b14b7ad41e17ba4" # Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  description = "The type of instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Value for the Name tag"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}
