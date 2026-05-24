# Devsu DevOps Python - GitOps Repository

GitOps repository used to manage Kubernetes manifests and Infrastructure as Code for the `devsu-devops-python` application.

This repository contains:

- Kubernetes manifests
- Kustomize overlays
- Terraform infrastructure
- Deployment automation scripts
- Environment-specific configurations

---

# Architecture

```text
Developer
   |
   v
Application Repository
   |
   v
GitHub Actions CI/CD
   |
   +--> Static Analysis
   +--> Tests
   +--> Coverage
   +--> Trivy Scan
   +--> Docker Build
   |
   v
GHCR Container Registry
   |
   v
GitOps Repository
   |
   v
Kustomize Overlays
   |
   v
GKE Cluster
   |
   +--> Deployment
   +--> HPA
   +--> Service
   +--> Ingress
   +--> Migration Job
   |
   v
Cloud SQL MySQL
```

---

# Repository Structure

```text
.
├── terraform/
│   ├── README.md
│   ├── main.tf
│   ├── outputs.tf
│   ├── variables.tf
│   └── terraform.tfvars.example
│
├── k8s/
│   ├── README.md
│   ├── base/
│   ├── overlays/
│   │   ├── dev/
│   │   └── prod/
│   └── scripts/
│
└── README.md
```

---

# Main Components

## Terraform

Responsible for provisioning:

- VPC
- Subnet
- GKE Autopilot Cluster
- Cloud SQL MySQL

---

## Kubernetes

Responsible for application deployment using:

- Deployment
- Service
- Ingress
- HPA
- Migration Job
- ConfigMaps
- Secrets
- Kustomize overlays

---

## Deployment Automation

The repository includes deployment scripts that:

- Create namespaces
- Create Kubernetes Secrets
- Read Terraform outputs
- Run database migrations
- Apply Kubernetes manifests
- Wait for rollout completion

---

# Environments

Supported overlays:

| Environment | Namespace |
|---|---|
| dev | `dev-devsu-demo` |
| prod | `prod-devsu-demo` |

---

# GitOps Workflow

```text
Application Repository
    ↓
GitHub Actions
    ↓
Docker Build & Push
    ↓
Update Kustomize image tag
    ↓
GitOps Repository
    ↓
Kubernetes Deployment
```

---

# Security Practices

Implemented security controls include:

- Non-root containers
- Read-only root filesystem
- Dropped Linux capabilities
- Kubernetes Secrets
- Dedicated migration jobs
- Static code analysis
- Trivy vulnerability scanning
- Pod security contexts

---

# Notes

This repository was designed for technical assessment purposes and demonstrates:

- Kubernetes administration
- Infrastructure as Code
- GitOps workflows
- CI/CD pipelines
- Cloud infrastructure provisioning
- Security hardening
- Production-oriented deployment practices