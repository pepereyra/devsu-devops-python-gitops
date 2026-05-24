# Kubernetes Deployment

This directory contains the Kubernetes manifests used to deploy the application using a GitOps-oriented structure with Kustomize.

---

# Structure

```text
k8s/
├── base/
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   ├── job-migrate.yaml
│   ├── kustomization.yaml
│   ├── devsu-devops-python-secret.example.yaml
│   └── devsu-devops-python-db-secret.example.yaml
│
├── overlays/
│   ├── dev/
│   │   ├── namespace.yaml
│   │   ├── configmap.yaml
│   │   └── kustomization.yaml
│   │
│   └── prod/
│       ├── namespace.yaml
│       ├── configmap.yaml
│       └── kustomization.yaml
│
└── scripts/
    └── deploy-dev.sh
```

---

# Base Resources

The `base/` directory contains reusable manifests shared across environments.

Resources include:

- Deployment
- Service
- Ingress
- HPA
- Migration Job
- Secret templates

---

# Overlays

The `overlays/` directory contains environment-specific customizations.

## Dev Overlay

Characteristics:

- 2 replicas
- development namespace
- automatic image updates
- development configuration

Namespace:

```text
dev-devsu-demo
```

---

## Prod Overlay

Characteristics:

- production namespace
- immutable image promotion
- production configuration

Namespace:

```text
prod-devsu-demo
```

---

# Deployment Script

The deployment script automates:

- Namespace creation
- Secret creation
- Terraform output retrieval
- Database migration execution
- Kubernetes deployment
- Rollout validation

Execute:

```bash
./k8s/scripts/deploy-dev.sh
```

---

# Security Hardening

Implemented controls:

- Non-root execution
- Read-only root filesystem
- Dropped Linux capabilities
- Pod security contexts
- Kubernetes Secrets

---

# Health Checks

## Liveness Probe

```text
/api/health/live/
```

Validates application process health.

---

## Readiness Probe

```text
/api/health/ready/
```

Validates application readiness and database availability.

---

# Horizontal Pod Autoscaler

Current configuration:

```text
Minimum replicas: 2
Maximum replicas: 5
CPU target: 70%
```

Validate HPA:

```bash
kubectl get hpa -n dev-devsu-demo
```

---

# Public Access

Application exposure uses:

```text
Kubernetes LoadBalancer Service
```

Validated endpoints:

```text
/api/health/live/
/api/health/ready/
/api/users/
```

---

# Secrets

Sensitive values are managed using Kubernetes Secrets.

Application secret:

```bash
kubectl create secret generic devsu-devops-python-secret
```

Database secret:

```bash
kubectl create secret generic devsu-devops-python-db-secret
```

Real secret values are intentionally excluded from Git.

---

# GitOps Workflow

```text
Application Repository
    ↓
GitHub Actions
    ↓
Build and publish image
    ↓
Update image tag in overlay
    ↓
Deployment through Kubernetes manifests
```

---

# Notes

The deployment was designed to demonstrate:

- Kubernetes administration
- GitOps workflows
- Production-oriented deployments
- Security best practices
- CI/CD integration
- Infrastructure automation