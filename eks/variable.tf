variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "saireddy-eks-01"
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}
