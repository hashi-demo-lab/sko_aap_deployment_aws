resource "vault_policy" "organizations" {
  for_each = var.organizations

  name = each.key

  policy = <<EOT
# Allow everything to be managed in the namespace (not recommended for production environments)
path "${each.key}/*" {
    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

resource "vault_policy" "read-only" {
  name = "read-only"

  policy = <<EOT
# Allow read-only access to all paths
path "*" {
	  capabilities = ["read","list"]
}
EOT
}