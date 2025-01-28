locals {
  create_deployment_id = var.deployment_id != "" ? 0 : 1
  # Common tags to be assigned to all resources
  persistent_tags = {
    purpose = "automation"
    environment = "ansible-automation-platform"
    deployment = "aap-infrastructure-${var.deployment_id}"
  }
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

resource "aws_key_pair" "admin" {
  key_name = "admin-key"
  public_key = file(var.infrastructure_ssh_public_key)
}

########################################
# RDS Instance
########################################
module "rds" {
  source = "./modules/rds"

  deployment_id = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  allocated_storage = var.infrastructure_db_allocated_storage
  allow_major_version_upgrade = var.infrastructure_db_allow_major_version_upgrade
  auto_minor_version_upgrade = var.infrastructure_db_auto_minor_version_upgrade
  engine_version = var.infrastructure_db_engine_version
  instance_class = var.infrastructure_db_instance_class
  multi_az = var.infrastructure_db_multi_az
  db_sng_description =  "Ansible Automation Platform Subnet Group"
  db_sng_name = "aap-infrastructure-${var.deployment_id}-subnet-group"
  db_sng_subnets = var.private_subnet_ids #this should be private subnet - to fix + secyurity groups
  db_sng_tags = merge(
    {
      Name = "aap-infrastructure-${var.deployment_id}-subnet-group"
    },
    local.persistent_tags
  ) 
  skip_final_snapshot = true
  storage_iops = var.infrastructure_db_storage_iops
  storage_encrypted = var.infrastructure_db_storage_encrypted
  storage_type = var.infrastructure_db_storage_type
  username = var.infrastructure_db_username
  password = var.infrastructure_db_password
  persistent_tags = local.persistent_tags
  vpc_security_group_ids = [aws_security_group.aap_infrastructure_sg.id]
  infrastructure_hub_count = var.infrastructure_hub_count
  infrastructure_eda_count = var.infrastructure_eda_count
  infrastructure_gateway_count = var.infrastructure_gateway_count
}

########################################
# Controller VM 
########################################

module "controller_vm" {
  source = "./modules/vms"

  app_tag = "controller"
  count = var.infrastructure_controller_count
  deployment_id = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix = random_string.instance_name_suffix.result
  vm_name_prefix = "controller-${count.index + 1}-"
  instance_ami = var.infrastructure_controller_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_controller_ami
  instance_type = var.infrastructure_controller_instance_type
  vpc_security_group_ids = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id = var.public_subnet_ids[0]
  key_pair_name = aws_key_pair.admin.key_name
  persistent_tags = local.persistent_tags
  infrastructure_ssh_private_key = var.infrastructure_ssh_private_key
  infrastructure_admin_username = var.infrastructure_admin_username
  aap_red_hat_username = var.aap_red_hat_username
  aap_red_hat_password = var.aap_red_hat_password
}

########################################
# Hub VM
########################################
module "hub_vm" {
  source = "./modules/vms"

  app_tag = "hub"
  count = var.infrastructure_hub_count
  deployment_id = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix = random_string.instance_name_suffix.result
  vm_name_prefix = "hub-${count.index + 1}-"
  instance_ami = var.infrastructure_hub_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_hub_ami
  instance_type = var.infrastructure_hub_instance_type
  vpc_security_group_ids = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id = var.public_subnet_ids[0]
  key_pair_name = aws_key_pair.admin.key_name
  persistent_tags = local.persistent_tags
  infrastructure_ssh_private_key = var.infrastructure_ssh_private_key
  infrastructure_admin_username = var.infrastructure_admin_username
  aap_red_hat_username = var.aap_red_hat_username
  aap_red_hat_password = var.aap_red_hat_password

}

########################################
# Gateway VM
########################################
module "gateway_vm" {
  source = "./modules/vms"

  count = var.infrastructure_gateway_count
  app_tag = "gateway"
  deployment_id = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix = random_string.instance_name_suffix.result
  vm_name_prefix = "gateway-${count.index + 1}-"
  instance_ami = var.infrastructure_controller_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_controller_ami
  instance_type = var.infrastructure_controller_instance_type
  vpc_security_group_ids = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id = var.public_subnet_ids[0]
  key_pair_name = aws_key_pair.admin.key_name
  persistent_tags = local.persistent_tags
  infrastructure_ssh_private_key = var.infrastructure_ssh_private_key
  infrastructure_admin_username = var.infrastructure_admin_username
  aap_red_hat_username = var.aap_red_hat_username
  aap_red_hat_password = var.aap_red_hat_password
}

########################################
# Execution VM
########################################
module "execution_vm" {
  source = "./modules/vms"

  count = var.infrastructure_execution_count
  app_tag = "execution"
  deployment_id = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix = random_string.instance_name_suffix.result
  vm_name_prefix = "execution-${count.index + 1}-"
  instance_ami = var.infrastructure_execution_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_execution_ami
  instance_type = var.infrastructure_execution_instance_type
  vpc_security_group_ids = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id = var.public_subnet_ids[0]
  key_pair_name = aws_key_pair.admin.key_name
  persistent_tags = local.persistent_tags
  infrastructure_ssh_private_key = var.infrastructure_ssh_private_key
  infrastructure_admin_username = var.infrastructure_admin_username
  aap_red_hat_username = var.aap_red_hat_username
  aap_red_hat_password = var.aap_red_hat_password
}

########################################
# Event-Driven Ansible VM
########################################
module "eda_vm" {
  source = "./modules/vms"

  count = var.infrastructure_eda_count
  app_tag = "eda"
  deployment_id = var.deployment_id == "" ? random_string.deployment_id[0].id : var.deployment_id
  instance_name_suffix = random_string.instance_name_suffix.result
  vm_name_prefix = "eda-${count.index + 1}-"
  instance_ami = var.infrastructure_eda_ami == "" ? data.hcp_packer_artifact.aap.external_identifier : var.infrastructure_eda_ami
  instance_type = var.infrastructure_eda_instance_type
  vpc_security_group_ids = [aws_security_group.aap_infrastructure_sg.id]
  subnet_id = var.public_subnet_ids[0]
  key_pair_name = aws_key_pair.admin.key_name
  persistent_tags = local.persistent_tags
  infrastructure_ssh_private_key = var.infrastructure_ssh_private_key
  infrastructure_admin_username = var.infrastructure_admin_username
  aap_red_hat_username = var.aap_red_hat_username
  aap_red_hat_password = var.aap_red_hat_password
}

resource "terraform_data" "inventory" {
  for_each = { for host, instance in flatten(module.controller_vm[*].vm_public_ip): host => instance }
  input = "${var.inventory_revision}-${each.key}"
  connection {
      type = "ssh"
      user = var.infrastructure_admin_username
      host = each.value
      private_key = file(var.infrastructure_ssh_private_key)
    }
  provisioner "file" {
    content = templatefile("${path.module}/templates/inventory.j2", { 
      aap_controller_hosts = module.controller_vm[*].vm_private_ip
      aap_gateway_hosts = module.gateway_vm[*].vm_private_ip
      aap_ee_hosts = module.execution_vm[*].vm_private_ip
      aap_hub_hosts = module.hub_vm[*].vm_private_ip
      aap_eda_hosts = module.eda_vm[*].vm_private_ip
      aap_eda_allowed_hostnames = module.eda_vm[*].vm_public_ip
      infrastructure_db_username = var.infrastructure_db_username
      infrastructure_db_password = var.infrastructure_db_password
      aap_red_hat_username = var.aap_red_hat_username
      aap_red_hat_password= var.aap_red_hat_password
      aap_controller_db_host = module.rds.infrastructure_controller_rds_hostname
      aap_gateway_db_host = module.rds.infrastructure_gateway_rds_hostname
      aap_hub_db_host = module.rds.infrastructure_hub_rds_hostname
      aap_eda_db_host = module.rds.infrastructure_eda_rds_hostname
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
