# variable "vault_addr" {
#   description = "vault address"
#   type        = string
# }

# variable "vault_token" {
#   description = "vault token"
#   type        = string
# }

variable "vault_child_namespaces" {
  type = set(string)
  default = [
    "team_1",
    "team_2",
    "team_3",
    "team_4",
  ]
}