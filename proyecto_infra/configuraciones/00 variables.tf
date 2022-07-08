variable "NOMBRE_PROYECTO" { default = "cicd" }
variable "TIPO_INSTANCIA" { default = "t2.micro" }
variable "BLOQUE_CIDR_VPC" { default = "10.0.0.0/16" }
variable "BLOQUE_CIDR_SUBRED_PUBLIC" { default = "10.0.150.0/24" }
variable "BLOQUE_CIDR_SUBRED_PRIVATE" { default = "10.0.0.0/24" }
variable "INTERNET" { default = "0.0.0.0/0" }
variable "AV_ZONES" {
  type = map(string)
  default = {
    a = "eu-west-3a"
    b = "eu-west-3b"
    c = "eu-west-3c"
  }
}
variable "IP_SERVIDOR" { default = "10.0.150.10" }
 