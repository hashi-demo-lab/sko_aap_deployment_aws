resource "aws_security_group" "aap_infrastructure_sg" {
  name = "aap-infrastructure-${var.deployment_id}-sg"
  description = "AAP security group"
  vpc_id = var.vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow external ports for SSH, HTTPS, and Automation Mesh"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow external ports for SSH, HTTPS, and Automation Mesh"
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow external ports for SSH, HTTPS, and Automation Mesh"
  }

  ingress {
    from_port = 27199
    to_port = 27199
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow external ports for SSH, HTTPS, and Automation Mesh"
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = [var.aws_vpc_cidr]
    description = "allow ping on local net"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.aws_vpc_cidr]
    description = "allow aap ports on local net"
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [var.aws_vpc_cidr]
    description = "allow aap ports on local net"
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [var.aws_vpc_cidr]
    description = "allow aap ports on local net"
  }
  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [var.aws_vpc_cidr]
    description = "allow aap ports on local net"
  }
  ingress {
    from_port = 8443
    to_port = 8443
    protocol = "tcp"
    cidr_blocks = [var.aws_vpc_cidr]
    description = "allow aap ports on local net"
  }
  ingress {
    from_port = 27199
    to_port = 27199
    protocol = "tcp"
    cidr_blocks = [var.aws_vpc_cidr]
    description = "allow aap ports on local net"
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "allow all outbound"
  }

  tags = merge(
    {
      Name = "aap-infrastructure-${var.deployment_id}-sg"
    },
    #var.persistent_tags
  )
}