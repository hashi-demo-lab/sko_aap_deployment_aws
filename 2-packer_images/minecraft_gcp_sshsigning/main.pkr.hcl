packer {
  required_plugins {
    googlecompute = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/googlecompute"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
  required_version = "~> 1.11"
}

locals {
  timestamp = formatdate("YYYY-MM-DD_hh-mm-ss", timestamp())
  ami_name  = "${var.ami_name}_${local.timestamp}"
}

source "googlecompute" "ubuntu" {
  image_name        = "packer-${var.name}-${local.timestamp}"
  image_description = "Ubuntu 22.04 LTS remote development server."
  image_family      = var.name

  project_id = var.gcp_project_id
  zone       = var.gce_zone
  network    = "default"

  source_image_family     = var.gce_source_image_family
  source_image_project_id = [var.gce_source_image_project_id]

  scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/compute",
    "https://www.googleapis.com/auth/devstorage.full_control"
  ]

  ssh_username    = var.ssh_username
  use_internal_ip = false

  tags = [var.name]
}

build {
  sources = ["source.googlecompute.ubuntu"]

  hcp_packer_registry {
    bucket_name = source.googlecompute.ubuntu.image_name
    description = "GCP Ubuntu 2204 AMI with docker and Vault ssh signing prereqs"

    bucket_labels = {
      owner   = "SKO"
      os      = "Ubuntu"
      version = "22.04"
    }

    build_labels = {
      timestamp = local.timestamp
    }
  }

  provisioner "ansible" {
    playbook_file = "${path.cwd}/ansible/playbook.yml"

    ansible_env_vars = [
      "ANSIBLE_DEPRECATION_WARNINGS=False",
      "ANSIBLE_HOST_KEY_CHECKING=False",
      "ANSIBLE_NOCOLOR=True",
      "ANSIBLE_NOCOWS=1",
      "VAULT_NAMESPACE=${var.vault_namespace}",
      "VAULT_URL=${var.vault_url}",
      "ANSIBLE_PYTHON_INTERPRETER=/usr/bin/python3",
    ]

    extra_arguments = [
      "--ssh-extra-args",
      "-o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa -o IdentitiesOnly=yes",
      "--scp-extra-args",
      "'-O'"
    ]
  }

  sources = [
    "source.amazon-ebs.img"
  ]
}