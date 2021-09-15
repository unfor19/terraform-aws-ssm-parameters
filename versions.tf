terraform {
  required_version = ">= 0.12.30"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.38"
    }
  }
}
