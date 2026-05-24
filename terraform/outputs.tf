output "cluster_name" {
  description = "GKE cluster name."
  value       = google_container_cluster.main.name
}

output "cluster_location" {
  description = "GKE cluster location."
  value       = google_container_cluster.main.location
}

output "network_name" {
  description = "VPC network name."
  value       = google_compute_network.main.name
}

output "subnet_name" {
  description = "Subnet name."
  value       = google_compute_subnetwork.main.name
}

output "get_credentials_command" {
  description = "Command to configure kubectl access."
  value       = "gcloud container clusters get-credentials ${google_container_cluster.main.name} --region ${google_container_cluster.main.location} --project ${var.project_id}"
}

output "cloud_sql_instance_name" {
  description = "Cloud SQL instance name."
  value       = google_sql_database_instance.mysql.name
}

output "cloud_sql_public_ip" {
  description = "Cloud SQL public IP address."
  value       = google_sql_database_instance.mysql.public_ip_address
}

output "cloud_sql_database_name" {
  description = "Application database name."
  value       = google_sql_database.app.name
}

output "cloud_sql_user" {
  description = "Application database user."
  value       = google_sql_user.app.name
}