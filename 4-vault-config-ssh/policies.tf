resource "vault_policy" "oraganizations" {
  for_each = var.oraganizations

  name = each.key

  policy = <<EOT
# Allow policies to be managed in the namespace
path "${each.key}/sys/policies/*" {
   capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Allow cubbyhole to be managed in the namespace
path "${each.key}/cubbyhole/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}

# Allow key-value secrets engine to be managed in the namespace
path "${each.key}/secrets/*" {
    capabilities = ["create", "read", "update", "delete", "list"]
}
EOT
}