# Red NAT con DHCP: acceso desde el anfitrión y salida a internet
resource "libvirt_network" "p1-nat" {
  name      = "p1-nat"
  mode      = "nat"
  domain    = "p1.local"
  addresses = ["192.168.200.0/24"]
  dhcp { enabled = true }
  dns { enabled = true }
  autostart = true
}

# Red de datos muy aislada: solo web <-> bd (IP estáticas, el anfitrión no tiene IP)
resource "libvirt_network" "p1-datos" {
  name      = "p1-datos"
  mode      = "none"
  autostart = true
}
