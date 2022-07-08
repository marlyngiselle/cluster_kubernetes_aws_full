variable "NOMBRE_PROYECTO" {}
variable "TIPO_INSTANCIA" {}
variable "IP_SERVIDOR" {}
variable "IMAGEN_OS" {}
variable "ID_SUBRED" {}
variable "IDS_SEC_GROUPS" {
  type    = list
  default = []
}
variable "LLAVE_SSH_PUBLICA" {}
variable "NUMERO" {}
variable "LISTA_NOMBRE_SERVIDORES"{
  type = list
  default = []
}

variable "TIPO_RED" {}



data "template_file" "mi_bootstrap" {
  template = <<-EOF
                #!/bin/bash
                sudo hostnamectl set-hostname ${var.LISTA_NOMBRE_SERVIDORES[var.NUMERO]}
              EOF
}

resource "aws_instance" "mi_vm" {
  tags                   = {Name = "vm-${var.LISTA_NOMBRE_SERVIDORES[var.NUMERO]}-${var.NOMBRE_PROYECTO}-${var.NUMERO+1}" }
  ami                    = var.IMAGEN_OS
  instance_type          = var.TIPO_INSTANCIA
  subnet_id              = var.ID_SUBRED
  vpc_security_group_ids = var.IDS_SEC_GROUPS
  key_name               = var.LLAVE_SSH_PUBLICA
  private_ip             = var.IP_SERVIDOR
  user_data              = "${data.template_file.mi_bootstrap.rendered}"
}

# output "la_ip_publica" {
#   value = aws_instance.mi_vm.public_ip 
# }

# output "la_ip_privada" {
#   value = aws_instance.mi_vm.private_ip 
# }