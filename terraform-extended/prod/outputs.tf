output "dummy_app_external_ip" {
  value = "${module.app.dummy_app_external_ip}"
}

output "dummy_db_internal_ip" {
  value = "${module.db.dummy_db_internal_ip}"
}
