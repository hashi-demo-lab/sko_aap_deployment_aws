resource "vault_mount" "kvv2" {
  path        = "secrets"
  type        = "kv-v2"
  options = {
    version = "2"
    type    = "kv-v2"
  }
  description = "kv-v2 secrets engine for the ${var.namespace} team"
  namespace = var.namespace
}