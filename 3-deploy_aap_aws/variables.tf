variable "deployment_id" {
  description = "Creates a random string that will be used in tagging for correlating the resources used with a deployment of AAP."
  type = string
}

variable "aws_vpc_cidr" {
  type = string
  description = "The CIDR block for the VPC"
  default = "10.200.0.0/16"
}

variable "aws_region" {
  description = "AWS Region to be used"
  type = string
  default = "us-east-1"

  validation {
  condition = can(regex("[a-z][a-z]-[a-z]+-[1-9]", var.aws_region))
  error_message = "Must be a valid AWS Region name."
  }
}

# hashicorp cloud platform (hcp) variables
variable "hcp_client_id" {
  description = "hcp client id"
  type        = string
}

variable "hcp_client_secret" {
  description = "hcp client secret"
  type        = string
}

# Database variables
variable "infrastructure_db_allocated_storage" {
  description = "The allocated storage in gibibytes"
  type = number
  default = 100
}

variable "infrastructure_db_allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed"
  type = bool
  default = false
}

variable "infrastructure_db_auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance"
  type = bool
  default = true
}
variable "infrastructure_db_instance_class" {
  description = "The instance type of the RDS instance"
  type = string
  default = "db.m5d.xlarge"
}

variable "infrastructure_db_engine_version" {
  description = "The database engine version to use"
  type = string
  default = "13.18"
}

variable "infrastructure_db_multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type = bool
  default = false
}

variable "infrastructure_db_storage_encrypted" {
  description = "Specifies whether the DB instance is encrypted"
  type = bool
  default = true
}

variable "infrastructure_db_storage_iops" {
  description = "The amount of provisioned IOPS"
  type = number
  default = 5000
}

variable "infrastructure_db_storage_type" {
  description = "The type of storage to use (defaults to io1 if iops is defined)"
  type = string
  default = "io1"
}

variable "infrastructure_admin_username" {
  description = "The admin username of the VM that will be deployed."
  type = string
  default = "ec2-user"
  nullable = false
}

variable "infrastructure_db_username" {
  description = "Database instance username"
  type = string
  default = "ansible"
}

variable "infrastructure_db_password" {
  description = "Database instance password"
  type = string
  sensitive = true
  default = "Hashicorp123!"
}

# Controller variables
variable "infrastructure_controller_count" {
  description = "The number of ec2 instances for controller"
  type = number
  default = 1
}

variable "infrastructure_controller_instance_type" {
  description = "Controller instance type"
  type = string
  default = "m7a.xlarge"
}

variable "infrastructure_controller_ami" {
  description = "Controller AMI"
  type = string
  default = ""
}

# EDA variables
variable "infrastructure_eda_count" {
  description = "The number of EDA instances"
  type = number
  default = "1"
}

variable "infrastructure_eda_instance_type" {
  description = "The eda instance type"
  type = string
  default = "m7a.xlarge"
}

variable "infrastructure_eda_ami" {
  description = "Even Driven Ansible AMI"
  type = string
  default = ""
}

# Execution variables
variable "infrastructure_execution_count" {
  description = "The number of execution instances"
  type = number
  default = 0
}

variable "infrastructure_execution_instance_type" {
  description = "The execution instance type"
  type = string
  default = "m7a.xlarge"
}
variable "infrastructure_execution_ami" {
  description = "Execution AMI"
  type = string
  default = ""
}

variable infrastructure_gateway_count {
  description = "The number of ec2 instances for AAP gateway"
  type = number
  default = 1
}

# Hub variables
variable "infrastructure_hub_count" {
  description = "The number of ec2 instances for hub"
  type = number
  default = 1
}

variable "infrastructure_hub_instance_type" {
  description = "The hub instance type"
  type = string
  default = "m7a.xlarge"
}

variable "infrastructure_hub_ami" {
  description = "Hub AMI"
  type = string
  default = ""
}

variable "infrastructure_postgres_count" {
  description = "The instance type of the RDS instance"
  type = number
  default = 1
}


variable "infrastructure_postgres_instance_type" {
  description = "The instance type of the RDS instance"
  type = string
  default = "m7a.xlarge"
}

variable "infrastructure_ssh_private_key" {
  description = "Private ssh key file path."
  type = string
  default = "~/.ssh/id_rsa"
}
variable "infrastructure_ssh_public_key" {
  description = "Public ssh key file path."
  type = string
  default = "~/.ssh/id_rsa.pub"
}
variable "aap_red_hat_username" {
  description = "Red Hat account name that will be used for Subscription Management. exmaple your username@hashicorp.com"
  type = string
}

variable "aap_red_hat_password" {
  description = "Red Hat account password."
  type = string
  sensitive = true
  
}

variable "aap_admin_password" {
  description = "The admin password to create for Ansible Automation Platform application."
  type = string
  sensitive = true
  default = "Hashicorp123!"
}

variable "infrastructure_aap_installer_inventory_path" {
  description = "Inventory path on the installer host"
  default = "/home/ec2-user/inventory_aws"
  type = string
}

variable "hcp_channel" {
  description = "The HashiCorp Cloud Platform channel to use for the deployment"
  type = string
  default = "latest"
}

variable "hcp_bucket" {
  description = "The HashiCorp Cloud Platform bucket to use for the deployment"
  type = string
  default = "rhel-9-aap"
}

variable "hcp_vault_public_fqdn" {
  description = "The public FQDN of the HashiCorp Vault instance"
  type = string
}

variable "inventory_revision" {
  description = "The revision of the inventory file"
  type = string
  default = "1"
}

variable "public_subnet_id" {
  description = "The public subnet IDs"
  type = string
  default = null
}