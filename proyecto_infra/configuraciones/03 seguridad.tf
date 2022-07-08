resource "aws_key_pair" "llave-ssh-neo" {
  key_name   = "llave-ssh-${var.NOMBRE_PROYECTO}"
  public_key = file("~/.ssh/id_ed25519.pub")

}

resource "aws_security_group" "firewall_instancia" {
  tags        = { Name = "sg-public-${var.NOMBRE_PROYECTO}" }
  name        = "${var.NOMBRE_PROYECTO}-sg"
  description = "Firewall de las instancias publicas"
  vpc_id      = aws_vpc.mi_vpc.id

  ingress {
    description = "Acceso Puerto SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "Acceso Nexus Frontend"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "Acceso Nexus Backend"
    from_port   = 8085
    to_port     = 8085
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "Acceso Jenkins Frontend"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }


  ingress {
    description = "Acceso HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "Acceso HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "Acceso K8s"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "Acceso K8s"
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "Acceso K8s"
    from_port   = 10259
    to_port     = 10259
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

  ingress {
    description = "Acceso K8s"
    from_port   = 10257
    to_port     = 10257
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

   ingress {
    description = "Acceso K8s"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }

     ingress {
    description = "Acceso K8s"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = [var.INTERNET]
  }



  ingress {
    description = "permite_ping"
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [var.INTERNET]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [var.INTERNET]
  }

}

resource "aws_network_acl" "firewall_subred" {
  tags   = { Name = "acl-public-$(var.NOMBRE_PROYECTO})" }
  vpc_id = aws_vpc.mi_vpc.id

  ingress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.INTERNET
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = var.INTERNET
    from_port  = 0
    to_port    = 0
  }

}

