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
  default     = "m7a.large"
  description = "The instance type to use for the builder"
  type        = string

  validation {
    condition     = contains(["t2.small", "t2.medium", "t2.large", "t3.small", "m5a.large","m7a.large"], var.instance_type)
    error_message = "The instance type must be one of: t2.small, t2.medium, t2.large.  The instance type t2.micro times out."
  }
}

variable "region" {
  default     = "us-east-1"
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
}

variable "public_subnet_id" {
  description = "The VPC ID to use for the builder"
  type        = string
}

variable "rhn_username" {
  description = "The Red Hat Network username to use for the builder"
  type        = string
}

variable "rhn_password" {
  description = "The Red Hat Network password to use for the builder"
  type        = string
}