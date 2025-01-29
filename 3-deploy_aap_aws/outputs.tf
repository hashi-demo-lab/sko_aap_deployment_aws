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
  value = "ssh -i ${var.deployment_id}.pem ec2-user@${module.controller_vm[0].vm_public_ip}"
}