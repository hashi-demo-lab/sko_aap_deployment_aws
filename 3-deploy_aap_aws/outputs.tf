output "deployment_id" {
  description = "Print Deployment ID"
  value = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
}

output "aws_region" {
  description = "Print AWS Region"
  value = var.aws_region
}

output "vpc_id" {
  description = "VPC outputs"
  value = var.vpc_id
}

output "postgres_vm_outputs" {
  description = "Database outputs"
  value = module.postgres_vm
}

output "controller_vm_outputs" {
  description = "VMs outputs"
  value = module.controller_vm
}

output "gateway_vm_outputs" {
  description = "VMs outputs"
  value = module.gateway_vm
}



output "ssh-command-controller" {
  description = "Public Subnet IDs"
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${module.controller_vm[0].vm_public_ip}"
}