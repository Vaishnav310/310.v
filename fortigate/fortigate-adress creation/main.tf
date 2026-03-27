terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.24.1"
    }
  }
}

provider "fortios" {
  hostname = "192.168.30.1"
  username = "terraform-user"
  password = "1ss6d5QszjdNq8QGhyhm5rr5n8tGbk"
  insecure = true
  vdom     = "root"
}

resource "fortios_firewall_address" "test1" {
  name            = "DNS-SERVER"
  subnet          = "192.168.11.11 255.255.255.255"
  type            = "ipmask"
  update_if_exist = true
}