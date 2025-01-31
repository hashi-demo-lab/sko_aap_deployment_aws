resource "vault_namespace" "children" {
  for_each  = var.oraganizations
  path      = each.key
}