resource "google_compute_address" "app_ip" {
  name = "dummy-app-ip"
}

resource "google_compute_instance" "dummy_app" {
  name         = "dummy-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["${var.app_tag}"]

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

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = "false"
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sed -i -e 's/<mongodb_ip_address>/${google_compute_instance.dummy_db.network_interface.0.network_ip}/g' ~/app/app.yml"
    ]
  }

  provisioner "remote-exec" {
    script = "files/start.sh"
  }
}

resource "google_compute_firewall" "firewall_app" {
  name    = "default-app-allow"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["${var.app_tag}"]
}
