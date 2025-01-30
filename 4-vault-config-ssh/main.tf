locals {
  deployment_configs = jsondecode(file("${path.root}/../deployment_outputs.json.tmp"))
  vault_addr = local.deployment_configs.hcp_vault_public_fqdn
  vault_token = local.deployment_configs.hcp_vault_root_token
}

module "secrets-engine-ssh" {
  source = "./modules/secrets-engine-ssh"

  for_each = var.vault_child_namespaces
  namespace = each.key
}