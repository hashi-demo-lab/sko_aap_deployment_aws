locals {
  create_deployment_id = var.deployment_id != "" ? 0 : 1
  # common tags to be assigned to all resources
  persistent_tags = {
    purpose = "automation"
    environment = "ansible-automation-platform"
    deployment = "aap-infrastructure-${var.deployment_id}"
  }
  key_pair_private_key = file("${path.root}/../${var.deployment_id}.pem")
}

resource "random_string" "deployment_id" {
  count = local.create_deployment_id
  length = 8
  special = false
  upper = false
  numeric = false
}

resource "random_string" "instance_name_suffix" {
  length = 8
  special = false
  upper = false
  numeric = false
}

# hcp packer lookup for ami
data "hcp_packer_version" "aap" {
  bucket_name  = "rhel-9-aap"
  channel_name = var.hcp_channel
}

data "hcp_packer_artifact" "aap" {
  bucket_name  = data.hcp_packer_version.aap.bucket_name
  channel_name = var.hcp_channel
  platform     = "aws"
  region       = var.aws_region
}

# aws lookup for vpc and subnets
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.deployment_id}"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}

########################################
# Controller VM
########################################

module "controller_vm" {
  source = "./modules/vms"

  app_tag                        = "controller"
  count                          = var.infrastructure_controller_count
  deployment_id                  = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix           = random_string.instance_name_suffix.result
  vm_name_prefix                 = "controller-${count.index + 1}-"
  instance_ami                   = var.infrastructure_controller_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_controller_ami
  instance_type                  = var.infrastructure_controller_instance_type
  vpc_security_group_ids         = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id                      = data.aws_subnets.public.ids[0]
  key_pair_name                  = var.deployment_id
  persistent_tags                = local.persistent_tags
  infrastructure_ssh_private_key = local.key_pair_private_key
  infrastructure_admin_username  = var.infrastructure_admin_username
  aap_red_hat_username           = var.aap_red_hat_username
  aap_red_hat_password           = var.aap_red_hat_password
}

########################################
# Hub VM
########################################
module "hub_vm" {
  source = "./modules/vms"

  app_tag                        = "hub"
  count                          = var.infrastructure_hub_count
  deployment_id                  = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix           = random_string.instance_name_suffix.result
  vm_name_prefix                 = "hub-${count.index + 1}-"
  instance_ami                   = var.infrastructure_hub_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_hub_ami
  instance_type                  = var.infrastructure_hub_instance_type
  vpc_security_group_ids         = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id                      = data.aws_subnets.public.ids[0]
  key_pair_name                  = var.deployment_id
  persistent_tags                = local.persistent_tags
  infrastructure_ssh_private_key = local.key_pair_private_key
  infrastructure_admin_username  = var.infrastructure_admin_username
  aap_red_hat_username           = var.aap_red_hat_username
  aap_red_hat_password           = var.aap_red_hat_password
}

########################################
# Gateway VM
########################################
module "gateway_vm" {
  source = "./modules/vms"

  count                          = var.infrastructure_gateway_count
  app_tag                        = "gateway"
  deployment_id                  = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix           = random_string.instance_name_suffix.result
  vm_name_prefix                 = "gateway-${count.index + 1}-"
  instance_ami                   = var.infrastructure_controller_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_controller_ami
  instance_type                  = var.infrastructure_controller_instance_type
  vpc_security_group_ids         = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id                      = data.aws_subnets.public.ids[0]
  key_pair_name                  = var.deployment_id
  persistent_tags                = local.persistent_tags
  infrastructure_ssh_private_key = local.key_pair_private_key
  infrastructure_admin_username  = var.infrastructure_admin_username
  aap_red_hat_username           = var.aap_red_hat_username
  aap_red_hat_password           = var.aap_red_hat_password
}

########################################
# Execution VM
########################################
module "execution_vm" {
  source = "./modules/vms"

  count                          = var.infrastructure_execution_count
  app_tag                        = "execution"
  deployment_id                  = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix           = random_string.instance_name_suffix.result
  vm_name_prefix                 = "execution-${count.index + 1}-"
  instance_ami                   = var.infrastructure_execution_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_execution_ami
  instance_type                  = var.infrastructure_execution_instance_type
  vpc_security_group_ids         = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id                      = data.aws_subnets.public.ids[0]
  key_pair_name                  = var.deployment_id
  persistent_tags                = local.persistent_tags
  infrastructure_ssh_private_key = local.key_pair_private_key
  infrastructure_admin_username  = var.infrastructure_admin_username
  aap_red_hat_username           = var.aap_red_hat_username
  aap_red_hat_password           = var.aap_red_hat_password
}

########################################
# Event-Driven Ansible VM
########################################
module "eda_vm" {
  source = "./modules/vms"

  count                          = var.infrastructure_eda_count
  app_tag                        = "eda"
  deployment_id                  = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix           = random_string.instance_name_suffix.result
  vm_name_prefix                 = "eda-${count.index + 1}-"
  instance_ami                   = var.infrastructure_eda_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_eda_ami
  instance_type                  = var.infrastructure_eda_instance_type
  vpc_security_group_ids         = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id                      = data.aws_subnets.public.ids[0]
  key_pair_name                  = var.deployment_id
  persistent_tags                = local.persistent_tags
  infrastructure_ssh_private_key = local.key_pair_private_key
  infrastructure_admin_username  = var.infrastructure_admin_username
  aap_red_hat_username           = var.aap_red_hat_username
  aap_red_hat_password           = var.aap_red_hat_password
}

########################################
# Postgres VM
########################################
module "postgres_vm" {
  source = "./modules/vms"

  app_tag                        = "postgres"
  deployment_id                  = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix           = random_string.instance_name_suffix.result
  vm_name_prefix                 = "postgres-"
  instance_ami                   = var.infrastructure_controller_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_controller_ami
  instance_type                  = var.infrastructure_postgres_instance_type
  vpc_security_group_ids         = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id                      = data.aws_subnets.public.ids[0]
  key_pair_name                  = var.deployment_id
  persistent_tags                = local.persistent_tags
  infrastructure_ssh_private_key = local.key_pair_private_key
  infrastructure_admin_username  = var.infrastructure_admin_username
  aap_red_hat_username           = var.aap_red_hat_username
  aap_red_hat_password           = var.aap_red_hat_password
}

locals {
  postgres_vm_ip = module.postgres_vm.vm_private_ip
}

resource "terraform_data" "inventory" {
  depends_on = [ module.postgres_vm, module.controller_vm ]
  for_each = { for host, instance in flatten(module.controller_vm[*].vm_public_ip): host => instance }
  connection {
      type = "ssh"
      user = var.infrastructure_admin_username
      host = each.value
      private_key = local.key_pair_private_key
    }
  provisioner "file" {
    content = templatefile("${path.module}/templates/inventory.j2", { 
      aap_controller_hosts = module.controller_vm[*].vm_private_ip
      aap_gateway_hosts = module.gateway_vm[*].vm_private_ip
      aap_hub_hosts = module.hub_vm[*].vm_private_ip
      aap_eda_hosts = module.eda_vm[*].vm_private_ip
      aap_eda_allowed_hostnames = module.eda_vm[*].vm_public_ip
      infrastructure_db_username = var.infrastructure_db_username
      infrastructure_db_password = var.infrastructure_db_password
      aap_red_hat_username = var.aap_red_hat_username
      aap_red_hat_password= var.aap_red_hat_password
      aap_postgres_db_host = local.postgres_vm_ip
      aap_admin_password = var.aap_admin_password
      infrastructure_admin_username = var.infrastructure_admin_username
    })
    destination = var.infrastructure_aap_installer_inventory_path
  }
  provisioner "file" {
    content = templatefile("${path.module}/templates/config.j2", { 
      aap_controller_hosts = module.controller_vm[*].vm_private_ip
      aap_ee_hosts = module.execution_vm[*].vm_private_ip
      aap_hub_hosts = module.hub_vm[*].vm_private_ip
      aap_eda_hosts = module.eda_vm[*].vm_private_ip
      aap_gateway_hosts = module.gateway_vm[*].vm_private_ip
      aap_postgres_hosts = [module.postgres_vm.vm_private_ip]
      infrastructure_admin_username = var.infrastructure_admin_username
    })
    destination = "/home/${var.infrastructure_admin_username}/.ssh/config"
  }
  provisioner "remote-exec" {
      inline = [
        "chmod 0644 /home/${var.infrastructure_admin_username}/.ssh/config",
        "sudo cp /home/${var.infrastructure_admin_username}/.ssh/config /root/.ssh/config",
      ]
  }
}
