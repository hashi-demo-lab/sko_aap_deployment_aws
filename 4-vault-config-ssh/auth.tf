resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_generic_endpoint" "userpass" {
  for_each = var.oraganizations

  path                 = "auth/userpass/users/${each.key}"
  ignore_absent_fields = true

  data_json = <<EOT
{
  "policies": ["${each.key}"],
  "password": "${var.vault_password}"
}
EOT

  depends_on = [
    vault_auth_backend.userpass
  ]
}