terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Using version 5.x for stability
    }
  }
}

provider "aws" {
  region = var.region # This refers to the variable in your variables.tf
}
