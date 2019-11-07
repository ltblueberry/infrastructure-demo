resource "google_compute_address" "app_ip" {
  name = "${var.env_name}-dummy-app-ip"
}

resource "google_compute_instance" "dummy_app" {
  name         = "${var.env_name}-dummy-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["${var.env_name}-${var.app_tag}"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_app" {
  name    = "default-allow-app-${var.env_name}"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.env_name}-${var.app_tag}"]
}
