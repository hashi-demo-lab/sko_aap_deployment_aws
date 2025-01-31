resource "vault_namespace" "oraganizations" {
  for_each  = var.oraganizations
  path      = each.key
}