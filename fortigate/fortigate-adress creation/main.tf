terraform {
  required_providers {
    fortios = {
      source  = "fortinetdev/fortios"
      version = "1.24.1"
    }
  }
}

provider "fortios" {
  hostname = "[IP_ADDRESS]"
  username = "terraform-user"
  password = "[PASSWORD]"
  insecure = true
  vdom     = "root"
}

resource "fortios_firewall_address" "test1" {
  name            = "DNS-SERVER"
  subnet          = "192.168.11.11 255.255.255.255"
  type            = "ipmask"
  update_if_exist = true
}