resource "vault_auth_backend" "approle" {
  type = "approle"
  
  namespace = var.namespace
}