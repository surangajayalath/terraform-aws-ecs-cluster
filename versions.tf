terraform {
  # required terraform version
  required_version = ">= 1.5.2"

  # required AWS privider version
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.48.0"
    }
  }
}