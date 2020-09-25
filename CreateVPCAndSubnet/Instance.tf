terraform {
  required_version = ">= 0.13"
}
provider "google" {

  credentials = file("tf-key.json")
  version     = "3.5.0"
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}
resource "google_compute_network" "vpc_network" {
  name = "new-terraform-network"
}


resource "google_compute_subnetwork" "public-subnetwork" {
  name          = "terraform-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.name
}
