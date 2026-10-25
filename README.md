# Proyecto1:  Terraform + Ansible

Escenario con dos máquinas (`web` y `bd`) creado con Terraform sobre libvirt y configurado con Ansible para desplegar una aplicación PHP con MariaDB (guestbook).
Aplicación: https://github.com/josedom24/guestbook_php/tree/main

## Requisitos

- libvirt/KVM con las imágenes `debian13-base.qcow2` y `ubuntu2604_plantilla.img` en el pool `default`
- Terraform (u OpenTofu) y Ansible
- Colección `community.mysql`

## Despliegue

```bash
cd opentofu
terraform init
terraform apply
cd ../ansible
ansible-playbook site.yaml
```
