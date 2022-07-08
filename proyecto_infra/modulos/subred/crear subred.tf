variable TIPO_RED {default = ""}
variable LETRA_AZ {default = ""}
variable LA_VPC {default = ""}
variable PROYECTO {default = ""}
variable BLOQUE_SUBRED_CIDR {default = ""}
variable MAPA_TRES_AV_ZONES {
    type = map(string)
    default = {}
}


resource "aws_subnet" "subred" {
  tags                    = { Name = "subred-${var.TIPO_RED}-${var.PROYECTO}" }
  vpc_id                  = var.LA_VPC
  cidr_block              = var.BLOQUE_SUBRED_CIDR
  map_public_ip_on_launch = var.TIPO_RED == "publica" ? true : false
  availability_zone       = var.MAPA_TRES_AV_ZONES[var.LETRA_AZ]
}

output "id_de_la_subred" {
    value = aws_subnet.subred.id
}