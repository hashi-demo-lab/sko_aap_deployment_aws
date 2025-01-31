# resource "vault_policy" "oraganizations" {
#   for_each = var.oraganizations

#   name = each.key

#   policy = <<EOT
# path "${each.key}/sys/policies/*" {
#    capabilities = ["create", "read", "update", "delete", "list", "sudo"]
# }
# EOT
# }