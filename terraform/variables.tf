variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Google Cloud region."
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "VPC network name."
  type        = string
  default     = "devsu-devops-vpc"
}

variable "subnet_name" {
  description = "Subnet name."
  type        = string
  default     = "devsu-devops-subnet"
}

variable "subnet_cidr" {
  description = "Subnet CIDR range."
  type        = string
  default     = "10.30.0.0/24"
}

variable "cluster_name" {
  description = "GKE Autopilot cluster name."
  type        = string
  default     = "devsu-devops-gke"
}

variable "db_instance_name" {
  description = "Cloud SQL MySQL instance name."
  type        = string
  default     = "devsu-devops-mysql"
}

variable "db_name" {
  description = "Application database name."
  type        = string
  default     = "devsu_demo"
}

variable "db_user" {
  description = "Application database user."
  type        = string
  default     = "devsu_user"
}

variable "db_password" {
  description = "Application database password."
  type        = string
  sensitive   = true
}