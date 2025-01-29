locals {
  deployment_configs = file("${path.root}/../deployment_outputs.json.tmp")
  vault_addr = jsondecode(local.deployment_configs).hcp_vault_public_fqdn
  vault_token = jsondecode(local.deployment_configs).hcp_vault_root_token
}   