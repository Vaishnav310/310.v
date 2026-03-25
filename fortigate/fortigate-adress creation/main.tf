terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.24.1"
    }
  }
}

provider "fortios" {
  hostname = "192.168.10.9"
  username = "admin"
  password = "password"
  insecure = true
  vdom     = "root"
}

resource "fortios_firewall_address" "test1" {
  name            = "terraform-test-ip"
  subnet          = "192.168.99.10 255.255.255.255"
  type            = "ipmask"
  update_if_exist = true
}