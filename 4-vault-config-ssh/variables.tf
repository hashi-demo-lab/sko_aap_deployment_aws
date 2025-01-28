variable "hcp_client_id" {
  description = "hcp client id"
  type        = string
}

variable "hcp_client_secret" {
  description = "hcp client secret"
  type        = string
  sensitive = true
}

variable "hcp_project_id" {
  description = "hcp project id"
  type        = string
}

variable "vault_addr" {
  description = "vault address"
  type        = string
}