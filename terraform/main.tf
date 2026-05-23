resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = google_compute_network.main.id
}

resource "google_container_cluster" "main" {
  name     = var.cluster_name
  location = var.region

  enable_autopilot = true

  network    = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.main.id

  deletion_protection = false

  release_channel {
    channel = "REGULAR"
  }
}