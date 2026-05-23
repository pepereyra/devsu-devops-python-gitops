# Terraform - GKE Autopilot Infrastructure

This directory contains the Terraform code required to provision the cloud infrastructure used to deploy the `devsu-devops-python` application on Google Kubernetes Engine (GKE) Autopilot.

---

# Provisioned Resources

The Terraform configuration creates:

- VPC Network
- Subnet
- GKE Autopilot Cluster

---

# Requirements

The following tools are required:

- Terraform >= 1.6
- Google Cloud SDK (`gcloud`)
- kubectl

---

# Authentication

Authenticate with Google Cloud:

```bash
gcloud auth login
```

Set the target project:

```bash
gcloud config set project <PROJECT_ID>
```

---

# Variables

The project uses the following Terraform variables:

| Variable | Description |
|---|---|
| `project_id` | Google Cloud project ID |
| `region` | GCP region |
| `network_name` | VPC name |
| `subnet_name` | Subnet name |
| `cluster_name` | GKE cluster name |

Example `terraform.tfvars`:

```hcl
project_id = "your-project-id"
region     = "us-central1"
```

---

# Usage

Initialize Terraform:

```bash
terraform init
```

Review execution plan:

```bash
terraform plan
```

Create infrastructure:

```bash
terraform apply
```

Show outputs:

```bash
terraform output
```

---

# Configure kubectl

After the cluster is created:

```bash
gcloud container clusters get-credentials devsu-devops-gke \
  --region us-central1 \
  --project <PROJECT_ID>
```

Validate cluster access:

```bash
kubectl config current-context
kubectl get nodes
```

---

# Deploy Kubernetes Manifests

From the repository root:

```bash
kubectl apply -k k8s/overlays/dev
```

Validate deployment:

```bash
kubectl get all -n devsu-demo
```

---

# Public Access

The application can be exposed publicly using a Kubernetes `LoadBalancer` service.

Example endpoints:

```text
/api/health/live/
/api/health/ready/
/api/users/
```

---

# Destroy Infrastructure

To avoid unnecessary cloud costs:

```bash
terraform destroy
```

---

# Cost Considerations

This infrastructure was designed to remain lightweight for technical evaluation purposes.

The deployment uses:

- GKE Autopilot
- Small container resource requests
- Minimal networking resources

However, cloud resources may still generate costs depending on usage time and enabled services.

---

# GitOps Integration

Terraform provisions the Kubernetes infrastructure only.

Application deployment is managed separately through the GitOps repository using:

- Kubernetes manifests
- Kustomize overlays
- GitHub Actions
- GHCR container images