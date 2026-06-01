variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}

variable "vms_metadata" {
  type = map(object({
    serial-port-enable  = number
    ssh_keys = string
  }))
  default = {
    web = {
      serial-port-enable  = 1
      ssh_keys        = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC90w+fSFMP/wZZ3YEhMBEXVvp05mwmx8yNzrTmHH4PRHE7UX8Fnhr1TOeGHXkFlGsZJSWSSmScj7mbefLDK6qHIzCKwUG1sAe0pqNqCI7PyMcYSa/Cdos1HFbhixW9N1YyoJIQv69si3w6lbc+VUoJpJ/wiDam9L4YuvLOk4UtbyEYsZeQS3fxZiSAwDOu2W+uHJEqQDmEMHFg9sJ06g530ujErTPLyft5cFg4C3XT1/CKAXVXZfK17e5mG2tNmPgUj/JGGphy6MUu/u81Si/wP8TzS3bz848xIEKKOY2DyOLiX1qnjBbEL+kzO9j4rdjfNj2aGcjSO/GC1ekRH6O9sC40qB8Ohgs+qzc+m5WQyaQxFykUtNRJ8lkBROtHhqZC+FgS3TWItru+8HY62FeIYyJDexKbP7zh72u4I0dj8ezPDooR520kfZ4JhWWvvtxmAzoamMNsH8/oax4X6L1xotq4Q4YPH/TxvTVivJRrZO8wytdQqKV+O2+bgR1RDgvkG0jg8PorhB1+v6q8JZpDFnZWHCznjC/vqUQAxZtJxS6q6O6H+GKc/nk0rueJF3n7Iy9w6fcGsX5eLIpW/tqG60iW9Woz6fwzItR5+aIdoUmj64Nho9aruMGkP5YXQFu6f6V8KzXwTf88H2xaEg5NItGTG+Tc28LD+r+EMy8lLw== your-email@example.com"
    }
    db = {
      serial-port-enable  = 1
      ssh_keys        = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC90w+fSFMP/wZZ3YEhMBEXVvp05mwmx8yNzrTmHH4PRHE7UX8Fnhr1TOeGHXkFlGsZJSWSSmScj7mbefLDK6qHIzCKwUG1sAe0pqNqCI7PyMcYSa/Cdos1HFbhixW9N1YyoJIQv69si3w6lbc+VUoJpJ/wiDam9L4YuvLOk4UtbyEYsZeQS3fxZiSAwDOu2W+uHJEqQDmEMHFg9sJ06g530ujErTPLyft5cFg4C3XT1/CKAXVXZfK17e5mG2tNmPgUj/JGGphy6MUu/u81Si/wP8TzS3bz848xIEKKOY2DyOLiX1qnjBbEL+kzO9j4rdjfNj2aGcjSO/GC1ekRH6O9sC40qB8Ohgs+qzc+m5WQyaQxFykUtNRJ8lkBROtHhqZC+FgS3TWItru+8HY62FeIYyJDexKbP7zh72u4I0dj8ezPDooR520kfZ4JhWWvvtxmAzoamMNsH8/oax4X6L1xotq4Q4YPH/TxvTVivJRrZO8wytdQqKV+O2+bgR1RDgvkG0jg8PorhB1+v6q8JZpDFnZWHCznjC/vqUQAxZtJxS6q6O6H+GKc/nk0rueJF3n7Iy9w6fcGsX5eLIpW/tqG60iW9Woz6fwzItR5+aIdoUmj64Nho9aruMGkP5YXQFu6f6V8KzXwTf88H2xaEg5NItGTG+Tc28LD+r+EMy8lLw== your-email@example.com"
    }
  }
}
  
variable vm_image_family {
  type = string
  default = "ubuntu-2004-lts"
}

variable vm_web_instance_name {
  type = string
  default = "netology-develop-platform-web"
}

variable vm_web_instance_platform_id {
  type = string
  default = "standard-v2"
}

variable vm_web_instance_cores {
  type = number
  default = 2
}

variable vm_web_instance_memory {
  type = number
  default = 1
}

variable vm_web_instance_core_fraction {
  type = number
  default = 5
}

variable vm_web_instance_preemptible {
  type = bool
  default = true
}

variable vm_web_instance_nat_use {
  type = bool
  default = true
}

# variable vm_web_instance_serial_port_enable {
#   type = number
#   default = 1
# }

variable vm_db_instance_name {
  type = string
  default = "netology-develop-platform-db"
}

variable vm_db_instance_platform_id {
  type = string
  default = "standard-v2"
}

variable vm_db_instance_cores {
  type = number
  default = 2
}

variable vm_db_instance_memory {
  type = number
  default = 2
}

variable vm_db_instance_core_fraction {
  type = number
  default = 20
}

variable vm_db_instance_preemptible {
  type = bool
  default = true
}

variable vm_db_instance_nat_use {
  type = bool
  default = true
}

# variable vm_db_instance_serial_port_enable {
#   type = number
#   default = 1
# }

variable school {
  type = string
  default = "netology"
}

variable app_env {
  type = string
  default = "develop"
}