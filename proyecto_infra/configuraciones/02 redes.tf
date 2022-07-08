resource "aws_vpc" "mi_vpc" {
  tags       = { Name = "vpc-public-${var.NOMBRE_PROYECTO}" }
  cidr_block = var.BLOQUE_CIDR_VPC
}

resource "aws_internet_gateway" "gw" {
  tags   = { Name = "igw-${var.NOMBRE_PROYECTO}" }
  vpc_id = aws_vpc.mi_vpc.id
}

resource "aws_route_table" "mi_router" {
  tags   = { Name = "router-public-${var.NOMBRE_PROYECTO}" }
  vpc_id = aws_vpc.mi_vpc.id

  route {
    cidr_block = var.INTERNET
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_main_route_table_association" "asociar_router_a_vpc" {
  vpc_id         = aws_vpc.mi_vpc.id
  route_table_id = aws_route_table.mi_router.id
}