output "dummy_app_external_ip" {
  value = "${google_compute_instance.dummy_app.network_interface.0.access_config.0.assigned_nat_ip}"
}

output "dummy_db_internal_ip" {
  value = "${google_compute_instance.dummy_db.network_interface.0.network_ip}"
}
