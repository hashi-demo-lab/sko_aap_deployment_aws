terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "~> 3.6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.15"
    }

    hcp = {
      source = "hashicorp/hcp"
      version = ">= 0.102.0"
    }
  }
  required_version = ">= 1.9"
}
# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}
