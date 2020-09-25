terraform {
  required_version = ">= 0.13"
}
provider "google" {
  version = "3.5.0"

  credentials = file("tf-key.json")
  project = "poc-project-286601"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name  = "custom-network-2"
}

resource "google_compute_instance" "vm_instance" {
  name         = "testinstance-1"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      //nat_ip = google_compute_address.vm_static_ip.address
    }
  }
}

resource "google_compute_address" "vm_static_ip" {
  name = "terraform-static-ip"
}

  /*network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
    }
  }*/
}
