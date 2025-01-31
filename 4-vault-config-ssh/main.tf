locals {
  deployment_configs = jsondecode(file("${path.root}/../deployment_outputs.json.tmp"))
  vault_addr = local.deployment_configs.hcp_vault_public_fqdn
  vault_token = local.deployment_configs.hcp_vault_root_token
}

module "onboarding-aap-orgs" {
  source = "./modules/onboarding-aap-orgs"

  for_each = var.oraganizations
  namespace = each.key
}