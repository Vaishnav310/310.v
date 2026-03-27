output "lxc_password" {
  value     = random_password.lxc_password.result
  sensitive = true
}

output "lxc_private_key" {
  value     = tls_private_key.lxc_key.private_key_pem
  sensitive = true
}

output "lxc_public_key" {
  value = tls_private_key.lxc_key.public_key_openssh
}

output "lxc_ip" {
  value = proxmox_virtual_environment_container.ubuntu_lxc.ipv4
}
