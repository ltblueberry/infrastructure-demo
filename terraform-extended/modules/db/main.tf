
resource "google_compute_instance" "dummy_db" {
  name         = "dummy-db"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["${var.db_tag}"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name    = "default-allow-mongo"
  network = "default"

  allow {
    protocol = "tcp"

    ports = ["27017"]
  }

  target_tags = ["${var.db_tag}"]
  source_tags = ["${var.app_tag}"]
}
