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

variable disk_image {
  description = "Disk image"
}

variable app_tag {
  description = "Application instance tag"
}
