# Generate random root password
resource "random_password" "lxc_password" {
  length           = 16
  override_special = "_%@"
  special          = true
}

# Generate SSH key pair
resource "tls_private_key" "lxc_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create the LXC container
resource "proxmox_virtual_environment_container" "ubuntu_lxc" {
  description  = "Ubuntu LXC - Managed by Terraform"
  node_name    = var.proxmox_node
  vm_id        = 200
  unprivileged = true

  features {
    nesting = true
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 1024
    swap      = 512
  }

  disk {
    datastore_id = "local-lvm"
    size         = 8
  }

  initialization {
    hostname = "ubuntu-lxc-200"

    dns {
      servers = ["8.8.8.8", "8.8.4.4"]
      domain  = "local"
    }

    ip_config {
      ipv4 {
        address = "192.168.10.200/24"
        gateway = "192.168.10.1"
      }
    }

    user_account {
      keys = [
        trimspace(tls_private_key.lxc_key.public_key_openssh)
      ]
      password = random_password.lxc_password.result
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    enabled  = true
    firewall = false
  }

  operating_system {
    # Directly reference the existing template on local storage
    template_file_id = "local:vztmpl/ubuntu-25.04-standard_25.04-1.1_amd64.tar.zst"
    type             = "ubuntu"
  }

  startup {
    order      = "3"
    up_delay   = "30"
    down_delay = "30"
  }

  start_on_boot = true
  started       = true

  wait_for_ip {
    ipv4 = true
  }
}
