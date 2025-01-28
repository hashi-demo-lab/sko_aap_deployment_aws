terraform {
  required_providers {

    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.20.0"
    }

    hcp = {
      source = "hashicorp/hcp"
      version = "~> 0.72.0"
    }
    
  }
}

provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
  project_id = var.hcp_project_id
}