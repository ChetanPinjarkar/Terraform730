
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">4.0, <6.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}