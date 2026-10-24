# Pool de almacenamiento de libvirt
variable "libvirt_pool_name" {
  type    = string
  default = "default"
}

# Imágenes base (tienen que estar en el pool)
variable "imagen_web" {
  type    = string
  default = "debian-13-plantilla.qcow2"
}

variable "imagen_bd" {
  type    = string
  default = "ubuntu_plantilla.img"
}

# Memoria de cada máquina (MB)
variable "memoria_web" {
  type    = number
  default = 1024
}

variable "memoria_bd" {
  type    = number
  default = 1024
}
