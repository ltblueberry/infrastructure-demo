output "dummy_db_internal_ip" {
  value = "${google_compute_instance.dummy_db.network_interface.0.network_ip}"
}