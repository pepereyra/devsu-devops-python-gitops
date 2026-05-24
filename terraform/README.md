# Terraform - GKE Autopilot Infrastructure

This directory contains the Terraform code required to provision the infrastructure used by the `devsu-devops-python` application.

Provisioned infrastructure is hosted on Google Cloud Platform.

---

# Provisioned Resources

Terraform creates the following resources:

- VPC Network
- Subnet
- GKE Autopilot Cluster
- Cloud SQL MySQL Instance
- Cloud SQL Database
- Cloud SQL User

---

# Requirements

Required tools:

- Terraform >= 1.6
- Google Cloud SDK (`gcloud`)
- kubectl

---

# Authentication

Authenticate with Google Cloud:

```bash
gcloud auth login
```

Set target project:

```bash
gcloud config set project <PROJECT_ID>
```

---

# Variables

Main variables:

| Variable | Description |
|---|---|
| `project_id` | Google Cloud project ID |
| `region` | GCP region |
| `network_name` | VPC name |
| `subnet_name` | Subnet name |
| `cluster_name` | GKE cluster name |
| `db_instance_name` | Cloud SQL instance name |
| `db_name` | Application database |
| `db_user` | Database username |
| `db_password` | Database password |

---

# Example terraform.tfvars

```hcl
project_id = "your-project-id"
region     = "us-central1"
db_password = "change-me"
```

---

# Usage

Initialize Terraform:

```bash
terraform init
```

Review plan:

```bash
terraform plan
```

Apply infrastructure:

```bash
terraform apply
```

Show outputs:

```bash
terraform output
```

---

# Terraform Outputs

Available outputs:

| Output | Description |
|---|---|
| `cluster_name` | GKE cluster name |
| `cluster_location` | Cluster region |
| `cloud_sql_instance_name` | Cloud SQL instance |
| `cloud_sql_public_ip` | Database public IP |
| `cloud_sql_database_name` | Database name |
| `cloud_sql_user` | Database user |

---

# Configure kubectl

After infrastructure creation:

```bash
gcloud container clusters get-credentials devsu-devops-gke \
  --region us-central1 \
  --project <PROJECT_ID>
```

Validate connectivity:

```bash
kubectl get nodes
```

---

# Cost Considerations

Infrastructure was intentionally designed to remain lightweight for technical evaluation purposes.

Resources include:

- GKE Autopilot
- Small container workloads
- Minimal Cloud SQL sizing
- Lightweight networking

Cloud costs may still apply depending on runtime duration.

---

# Security Notes

For simplicity during technical evaluation:

- Cloud SQL uses public IP
- Authorized networks temporarily allow broad access
- TLS enforcement is not enabled

Production environments should instead use:

- Private networking
- Authorized CIDRs
- Cloud SQL Auth Proxy
- TLS enforcement

---

# Destroy Infrastructure

To avoid unnecessary cloud costs:

```bash
terraform destroy
```

---

# GitOps Integration

Terraform provisions infrastructure only.

Application deployment is managed separately using:

- Kubernetes manifests
- Kustomize overlays
- GitHub Actions
- GHCR container images