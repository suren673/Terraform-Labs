provider "google" {
  version = "3.5.0"

  credentials = file("tf-key.json")

  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

resource "google_compute_network" "vpc_network" {
  name = "west-terraform-network"
  //auto_create_subnetworks = "true"
}
resource "google_compute_instance" "vm_instance" {
  name                    = "terraform-host"
  metadata_startup_script = file("startup.sh")
  machine_type            = "f1-micro"
  tags                    = ["web"]
  zone                    =  var.gcp_zone
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

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags   = ["web"]
  source_ranges = ["0.0.0.0/0"]
}
