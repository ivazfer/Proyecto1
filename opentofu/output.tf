output "web" {
  value = {
    nombre   = "web"
    ip_nat   = try(libvirt_domain.web.network_interface[0].addresses[0], "No disponible")
    ip_datos = "10.0.0.10"
  }
}

output "bd" {
  value = {
    nombre   = "bd"
    ip_nat   = try(libvirt_domain.bd.network_interface[0].addresses[0], "No disponible")
    ip_datos = "10.0.0.20"
  }
}
