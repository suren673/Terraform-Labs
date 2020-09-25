terraform {
  required_version = ">= 0.12"
}
provider "google" {
  project     = var.gcp_project
  credentials = file(var.gcp_auth_file)
  region      = var.gcp_region
  //network = var.vpn_name
  zone = var.gcp_zone
}

resource "google_compute_network" "vpc_network" {

  name                    = "custom-network-1"
  auto_create_subnetworks = "true"
}

resource "google_compute_instance" "vm_instance" {
  name         = "testinstance"
  machine_type = var.machine_types[var.environment] //"f1-micro"
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
      nat_ip = google_compute_address.vm_static_ip.address
    }
  }

  /*network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
    }
  }*/
}

resource "google_compute_address" "vm_static_ip" {
  //name = "10.128.0.12"
  name = "terraform-static-ip"
}

/*output "ip" {
  value = google_compute_address.vm_static_ip.address
}

output "machinetype" {

  value = google_compute_instance.vm_instance.machine_type
}*/

/*terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}*/

resource "google_storage_bucket" "mycucket" {
  name     = "terraform-storgae-bucket323"
  location = "US"
}
