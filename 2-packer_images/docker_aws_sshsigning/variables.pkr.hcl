variable "ami_name" {
  default     = "ubuntu-2204-sko"
  description = "The name of the AMI to create"
  type        = string
}

variable "ami_owner" {
  default     = "099720109477"
  description = "The owner of the AMI to use as a base (Default: Amazon)"
  type        = string
}

variable "ami_filter" {
  default = {
    name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  description = "The filter to use to find the source AMI"
  type        = map(string)
}

variable "instance_type" {
  default     = "m7i.large"
  description = "The instance type to use for the builder"
  type        = string

  validation {
    condition     = contains(["t2.small", "t2.medium", "t2.large", "t3.small", "m5a.large","m7a.large", "m7i.large"], var.instance_type)
    error_message = "The instance type must be one of: t2.small, t2.medium, t2.large.  The instance type t2.micro times out."
  }
}

variable "region" {
  default     = "us-east-1"
  description = "The region to use for the builder"
  type        = string
}

variable "ssh_username" {
  default     = "ubuntu"
  description = "The SSH username to use for the builder"
  type        = string
}

# variable "vpc_id" {
#   description = "The VPC ID to use for the builder"
#   type        = string
# }

# variable "public_subnet_id" {
#   description = "The VPC ID to use for the builder"
#   type        = string
# }

