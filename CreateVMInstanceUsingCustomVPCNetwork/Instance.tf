terraform {
  required_version = ">= 0.13"
}
provider "google" {
  version = "3.5.0"

  credentials = file(var.gcp_auth_file)
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

resource "google_compute_network" "vpc_network" {
  name = "vpcnetwork-2"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance2"
  machine_type = "f1-micro"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
