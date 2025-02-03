packer {
  required_plugins {
    amazon = {
      version = "~> 1"
      source  = "github.com/hashicorp/amazon"
    }
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
  required_version = "~> 1.11"
}

data "amazon-ami" "ubuntu" {
  region      = var.region
  filters     = var.ami_filter
  most_recent = true
  owners      = [var.ami_owner]
}

locals {
  timestamp = formatdate("YYYY-MM-DD_hh-mm-ss", timestamp())
  ami_name  = "${var.ami_name}_${local.timestamp}"
}

source "amazon-ebs" "img" {
  ami_name      = local.ami_name
  instance_type = var.instance_type
  region        = var.region
  source_ami    = data.amazon-ami.ubuntu.id
  ssh_username  = var.ssh_username
  associate_public_ip_address = true
  # subnet_id = var.public_subnet_id
  # vpc_id = var.vpc_id
}

build {
  name = var.ami_name

  hcp_packer_registry {
    bucket_name = var.ami_name
    description = "Base RHEL 9 AMI with Ansible Automation Platform installer package preloaded."

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
    playbook_file = "playbook.yml"
    sftp_command  = "/usr/libexec/openssh/sftp-server -e"

    ansible_env_vars = [
      "ANSIBLE_DEPRECATION_WARNINGS=False",
      "ANSIBLE_HOST_KEY_CHECKING=False",
      "ANSIBLE_NOCOLOR=True",
      "ANSIBLE_NOCOWS=1",
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