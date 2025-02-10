resource "tls_private_key" "ssh-key" {
  algorithm = "ED25519"
  rsa_bits  = "2048"
}