locals {
  ssh_public_key = file("~/.ssh/id_rsa.pub")
  
  common_metadata = {
    serial-port-enable = "true"
    ssh-keys           = "ubuntu:${local.ssh_public_key}"
  }
}