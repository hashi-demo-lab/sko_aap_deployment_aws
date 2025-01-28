terraform {
  required_providers {

    vault = {
      source  = "hashicorp/vault"
      version = "4.6.0"
    }

    hcp = {
      source = "hashicorp/hcp"
      version = "0.102.0"
    }
    
  }
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
  project_id = var.hcp_project_id
}

provider "vault" {
  address = var.vault_addr
  #VAULT_TOKEN is set in the environment
}