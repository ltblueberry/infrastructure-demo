variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west4"
}

variable zone {
  description = "Zone"
  default     = "europe-west4-b"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable app_disk_image {
  description = "Disk image for nodejs app"
  default     = "nodejs-base"
}

variable app_tag {
  description = "Application instance tag"
}

variable db_disk_image {
  description = "Disk image for mongodb"
  default     = "mongo-base"
}

variable db_tag {
  description = "DB instance tag"
}

variable env_name {
  description = "Environment name"
  default     = "stage"
}
