# count-vm.tf

variable "vm_name_prefix" {
  type        = string
  default     = "web"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v2"
}

variable "vm_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}

variable "vm_preemptible" {
  type        = bool
  default     = true
}

variable "vm_nat" {
  type        = bool
  default     = true
}

variable "vm_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
}


data "yandex_compute_image" "ubuntu_count" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "web-vm" {
  count = 2
  name        = "${var.vm_name_prefix}-${count.index + 1}"
  platform_id = var.vm_platform_id

  depends_on = [
    yandex_compute_instance.db-vm
  ]

  resources {
    cores         = var.vm_resources.cores
    memory        = var.vm_resources.memory
    core_fraction = var.vm_resources.core_fraction
  }

    boot_disk {
        initialize_params {
        image_id = data.yandex_compute_image.ubuntu_count.image_id
        size     = var.common_boot_disk_config.size
        }
    }
  
  scheduling_policy {
    preemptible = var.vm_preemptible
  }
  
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = local.common_metadata
}