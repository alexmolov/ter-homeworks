# for_each-vm.tf

variable "each_vm" {
  description = "Configuration for database VMs"
  type = map(object({
    cpu             = number
    ram             = number
    disk_volume     = number
    platform_id     = optional(string, "standard-v3")
    core_fraction   = optional(number, 20)
    preemptible     = optional(bool, false)
    nat             = optional(bool, false)
    image_family    = optional(string, "ubuntu-2204-lts")
    disk_type       = optional(string, "network-ssd")
  }))
  default = {
    main = {
      cpu         = 2
      ram         = 4
      disk_volume = 20
    }
    replica = {
      cpu         = 4
      ram         = 8
      disk_volume = 30
      preemptible = true
      nat         = false
    }
  }
}


data "yandex_compute_image" "ubuntu_db" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "db-vm" {
  for_each = var.each_vm 
  
  name        = each.key
  platform_id = each.value.platform_id
  
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.image_id
      size     = each.value.disk_volume
    }
  }
  
  scheduling_policy {
    preemptible = each.value.preemptible
  }
  
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = each.value.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.common_metadata
}