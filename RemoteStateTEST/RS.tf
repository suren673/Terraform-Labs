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
  name = "new-terraform-network"
}

terraform {
  backend "gcs" {
    bucket      = "tf-state-prod-terraform-1"
    prefix      = "terraform-1"
    credentials = "tf-key.json"

  }
}
