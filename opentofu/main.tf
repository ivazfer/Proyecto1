##############################################
# web — Debian 13 (Apache + PHP)
##############################################

resource "libvirt_volume" "web-disk" {
  name             = "p1-web.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.imagen_web
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
  size             = 10 * 1024 * 1024 * 1024 # 10 GB
}

resource "libvirt_cloudinit_disk" "web-cloudinit" {
  name           = "p1-web-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-web.yaml")
  network_config = file("${path.module}/cloud-init/network-config-web.yaml")
}

resource "libvirt_domain" "web" {
  name   = "p1-web"
  memory = var.memoria_web
  vcpu   = 2

  # ens3: red NAT con DHCP
  network_interface {
    network_id     = libvirt_network.p1-nat.id
    wait_for_lease = true
  }

  # ens4: red de datos (10.0.0.10)
  network_interface {
    network_id = libvirt_network.p1-datos.id
  }

  disk { volume_id = libvirt_volume.web-disk.id }
  cloudinit = libvirt_cloudinit_disk.web-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}

##############################################
# bd — Ubuntu 26.04 (MariaDB)
##############################################

resource "libvirt_volume" "bd-disk" {
  name             = "p1-bd.qcow2"
  pool             = var.libvirt_pool_name
  base_volume_name = var.imagen_bd
  base_volume_pool = var.libvirt_pool_name
  format           = "qcow2"
  size             = 10 * 1024 * 1024 * 1024 # 10 GB
}

resource "libvirt_cloudinit_disk" "bd-cloudinit" {
  name           = "p1-bd-cloudinit.iso"
  pool           = var.libvirt_pool_name
  user_data      = file("${path.module}/cloud-init/user-data-bd.yaml")
  network_config = file("${path.module}/cloud-init/network-config-bd.yaml")
}

resource "libvirt_domain" "bd" {
  name   = "p1-bd"
  memory = var.memoria_bd
  vcpu   = 2

  # ens3: red NAT con DHCP
  network_interface {
    network_id     = libvirt_network.p1-nat.id
    wait_for_lease = true
  }

  # ens4: red de datos (10.0.0.20)
  network_interface {
    network_id = libvirt_network.p1-datos.id
  }

  disk { volume_id = libvirt_volume.bd-disk.id }
  cloudinit = libvirt_cloudinit_disk.bd-cloudinit.id

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
}
