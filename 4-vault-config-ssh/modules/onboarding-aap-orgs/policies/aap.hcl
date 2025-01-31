# write and manage secrets in key-value secrets engine
path "secret*" {
  capabilities = [ "create", "read", "update", "delete", "list", "patch" ]
}