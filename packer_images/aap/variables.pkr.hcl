variable "ami_name" {
  default     = "rhel-9-aap"
  description = "The name of the AMI to create"
  type        = string
}

variable "ami_owner" {
  default     = "309956199498"
  description = "The owner of the AMI to use as a base (Default: Amazon)"
  type        = string
}

variable "ami_filter" {
  default = {
    name                = "RHEL-9.*.*_HVM-*-x86_64-0-Hourly2-GP3"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  description = "The filter to use to find the source AMI"
  type        = map(string)
}

variable "instance_type" {
  default     = "t3.small"
  description = "The instance type to use for the builder"
  type        = string

  validation {
    condition     = contains(["t2.small", "t2.medium", "t2.large", "t3.small"], var.instance_type)
    error_message = "The instance type must be one of: t2.small, t2.medium, t2.large.  The instance type t2.micro times out."
  }
}

variable "region" {
  default     = "ap-southeast-2"
  description = "The region to use for the builder"
  type        = string
}

variable "ssh_username" {
  default     = "ec2-user"
  description = "The SSH username to use for the builder"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to use for the builder"
  type        = string
  default = "vpc-0374a0be7101da63d"
}

variable "subnet_id" {
  description = "The VPC ID to use for the builder"
  type        = string
  default = "subnet-032112892fee063e6"
}