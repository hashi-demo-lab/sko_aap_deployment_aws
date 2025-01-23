# packer-ansible-aap

Builds an AMI using Packer and Ansible. This example uses RHEL 9 AMI as the base image and installs the Ansible Automation Platform installer package after updating the distribution.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_amazon"></a> [amazon](#requirement\_amazon) | ~> 1.3 |
| <a name="requirement_ansible"></a> [ansible](#requirement\_ansible) | ~> 1.1 |

## Plugins

| Name | Version |
|------|---------|
| <a name="requirement_amazon"></a> [amazon](#requirement\_amazon) | ~> 1.3 |
| <a name="requirement_ansible"></a> [ansible](#requirement\_ansible) | ~> 1.1 |

## Sources

| Name | Type |
|------|------|
| [amazon-ebs.img](https://developer.hashicorp.com/packer/integrations/hashicorp/amazon/latest/components/builder/ebs) | source |

## Provisioners

| Name | Source |
|------|------|
| [ansible](https://developer.hashicorp.com/packer/integrations/hashicorp/ansible/latest/components/provisioner/ansible) | [playbook.yml](playbook.yml) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_filter"></a> [ami\_filter](#input\_ami\_filter) | The filter to use to find the source AMI | `map(string)` | <pre>{<br>  "name": "RHEL-9.*.*_HVM-*-x86_64-82-Hourly2-GP3",<br>  "root-device-type": "ebs",<br>  "virtualization-type": "hvm"<br>}</pre> | no |
| <a name="input_ami_name"></a> [ami\_name](#input\_ami\_name) | The name of the AMI to create | `string` | `"rhel-9-aap"` | no |
| <a name="input_ami_owner"></a> [ami\_owner](#input\_ami\_owner) | The owner of the AMI to use as a base (Default: Amazon) | `string` | `"309956199498"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type to use for the builder | `string` | `"t2.small"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region to use for the builder | `string` | `"us-east-1"` | no |
| <a name="input_ssh_username"></a> [ssh\_username](#input\_ssh\_username) | The SSH username to use for the builder | `string` | `"ec2-user"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->