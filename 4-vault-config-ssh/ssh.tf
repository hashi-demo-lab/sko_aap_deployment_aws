resource "vault_mount" "ssh" {
  for_each = vault_namespace.children

  path = "ssh"
  type = "ssh"

  namespace = each.key
}
