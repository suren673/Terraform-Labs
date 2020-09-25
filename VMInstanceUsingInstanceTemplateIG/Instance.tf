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

resource "google_compute_instance_template" "webserver" {

  name                    = "standard server"
  machine_type = "n1-standard1-1"
  metadata_startup_script = "apt-get update && apt-get install -y nginx"

  network_interface {
    network = "default"
    access_config {

    }
  }

  disk {
    source_image = "debian-cloud/debian-8"
    auto_delete = true
    boot = true
  }

}

resource "google_compute_instance_group_manager" "webservers" {
  name = "my-webserver"
  instance_template = google_compute_instance_template.webserver.self_link
  base_instance_name = "webserver"
  zone = "us-west1-a"
  target_size =3
  named_port {
    name ="http"
    port = 80
  }

}

module "gce_lb_http" {
  source = "GoogleCloudPlatform/lb-http/google"
  name = "webserver"
  target_tags = ["http"]
  backend = {
    "0" =[
      {
        group = "{google_compute_instance_group_manager.webservers.instance_group}" }
    ],
  }
  backend_params = [
    "/, http, 80, 10" ]
}
