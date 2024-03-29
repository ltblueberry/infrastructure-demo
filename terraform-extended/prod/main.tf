provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

terraform {
  backend "gcs" {
    bucket  = "demo-89p13-terraform-state"
    prefix  = "production"
  }
}

module "app" {
  source = "../modules/app"
  env_name = "${var.env_name}"
  zone = "${var.zone}" 
  public_key_path = "${var.public_key_path}" 
  app_disk_image = "${var.app_disk_image}"
  app_tag = "${var.app_tag}"
}


module "db" {
  source = "../modules/db"
  env_name = "${var.env_name}"
  zone = "${var.zone}" 
  public_key_path = "${var.public_key_path}" 
  app_tag = "${var.app_tag}"
  db_disk_image = "${var.db_disk_image}"
  db_tag = "${var.db_tag}"
}

module "vpc" {
  source = "../modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}