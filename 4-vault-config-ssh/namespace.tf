resource "vault_namespace" "children" {
  for_each  = var.vault_child_namespaces
  path      = each.key
}