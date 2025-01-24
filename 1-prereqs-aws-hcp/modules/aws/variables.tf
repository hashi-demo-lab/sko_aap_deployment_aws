variable "region" {
  description = "AWS region"
  type        = string
}

variable "deployment_id" {
  description = "Deployment id"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "hcp_hvn_provider_account_id" {
  description = "HCP HVN provider account id"
  type        = string
}

variable "hcp_hvn_cidr" {
  description = "HCP HVN cidr"
  type        = string
}