# ansible.tf

locals {
  inventory_groups = [
    {
      name = "webservers"
      vms = [
        for vm in yandex_compute_instance.web-vm : {
          name = vm.name
          network_interface = [
            {
              nat_ip_address = vm.network_interface[0].nat_ip_address
            }
          ]
          fqdn = vm.fqdn
        }
      ]
    },
    {
      name = "databases"
      vms = [
        for name, vm in yandex_compute_instance.db-vm : {
          name = name
          network_interface = [
            {
              nat_ip_address = vm.network_interface[0].nat_ip_address
            }
          ]
          fqdn = vm.fqdn
        }
      ]
    },
    {
      name = "storage"
      vms = [
        {
          name = yandex_compute_instance.storage.name
          network_interface = [
            {
              nat_ip_address = yandex_compute_instance.storage.network_interface[0].nat_ip_address
            }
          ]
          fqdn = yandex_compute_instance.storage.fqdn
        }
      ]
    }
  ]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tpl", {
    groups = local.inventory_groups
  })
  filename = "${path.module}/inventory.ini"
}