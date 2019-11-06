provider "google" {
  version = "1.4.0"
  project = "infra-258109"
  region  = "europe-west4"
}

resource "google_compute_instance" "dummy_app" {
    name         = "dummy-app"
    machine_type = "g1-small"
    zone         = "europe-west4-b"
    tags         = ["dummy-server"]
    boot_disk {
        initialize_params {
            image = "nodejs-base"
        }
    }
    network_interface {
        network = "default"
        access_config {}
    }
    metadata{
        ssh-keys = "appuser:${file("~/.ssh/gcloud_rsa.pub")}"
    }

    connection {
        type        = "ssh"
        user        = "appuser"
        agent       = "false"
        private_key = "${file("~/.ssh/gcloud_rsa")}"
    }

    provisioner "remote-exec" {
        script = "files/deploy.sh"
    }
 }

 resource "google_compute_firewall" "firewall_app" {
    name    = "allow-app-default"
    network = "default"
    allow {
        protocol = "tcp"
        ports    = ["3000"]
    }
    source_ranges = ["0.0.0.0/0"]
    target_tags = ["dummy-server"]
}

