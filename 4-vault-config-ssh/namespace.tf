resource "vault_namespace" "organizations" {
  for_each  = var.organizations
  path      = each.key
}