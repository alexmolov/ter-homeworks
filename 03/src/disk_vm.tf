# disk_vm.tf

variable "disk_size_gb" {
  type        = number
  default     = 1
}

variable "disk_type" {
  type        = string
  default     = "network-ssd"
}

variable "disk_name_prefix" {
  type        = string
  default     = "disk"
}

resource "yandex_compute_disk" "storage" {
  count = 3
  
  name     = "${var.disk_name_prefix}-${count.index + 1}"
  type     = var.disk_type
  zone     = var.default_zone
  size     = var.disk_size_gb
}

variable "storage_vm_name" {
  type        = string
  default     = "storage"
}

variable "storage_vm_platform_id" {
  type        = string
  default     = "standard-v2"
}

variable "storage_vm_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

variable "storage_vm_preemptible" {
  type        = bool
  default     = true
}


data "yandex_compute_image" "ubuntu_storage" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "storage" {
  name        = var.storage_vm_name
  platform_id = var.storage_vm_platform_id
  
  resources {
    cores         = var.storage_vm_resources.cores
    memory        = var.storage_vm_resources.memory
    core_fraction = var.storage_vm_resources.core_fraction
  }
  
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_storage.image_id
      size     = var.common_boot_disk_config.size
    }
  }
  
  scheduling_policy {
    preemptible = var.storage_vm_preemptible
  }
  
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage
    
    content {
      disk_id = secondary_disk.value.id
    }
  }
  
  metadata = local.common_metadata
}