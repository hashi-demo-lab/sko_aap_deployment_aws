resource "vault_auth_backend" "approle" {
  type = "approle"

  tune {
    default_lease_ttl = "2190h"
    max_lease_ttl     = "4380h"
  }
  
  namespace = var.namespace
}