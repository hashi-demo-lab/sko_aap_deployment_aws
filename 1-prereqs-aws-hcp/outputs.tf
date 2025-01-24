// generic outputs

output "deployment_id" {
  description = "deployment identifier"
  value       = local.deployment_id
}

output "hcp_vault_public_fqdn" {
  description = "HCP vault public fqdn"
  value       = module.vault-hcp.public_endpoint_url
}

output "hcp_vault_private_fqdn" {
  description = "HCP vault private fqdn"
  value       = module.vault-hcp.private_endpoint_url
}

output "hcp_vault_root_token" {
  description = "HCP vault root token"
  value       = nonsensitive(module.vault-hcp.root_token)
}

output "vpc_id" {
  description = "AWS VPC ID"
  value       = module.infra-aws.vpc_id
}

output "public_subnet_ids" {
  description = "AWS VPC ID"
  value       = module.infra-aws.public_subnet_ids
}

output "private_subnet_ids" {
  description = "AWS VPC ID"
  value       = module.infra-aws.private_subnet_ids
}


output "lab_commands" {
  description = "lab command helpers"
  value = {
    "vault_login" = "export"
    "vault_secrets" = "vault kv get secret/data/hello"
  }
  
}