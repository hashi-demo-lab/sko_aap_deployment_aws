resource "vault_policy" "oraganizations" {
  for_each = var.oraganizations

  name = each.key

  policy = <<EOT
# Allow verything to be managed in the namespace (not recommended for production environments)
path "${each.key}/*" {
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}