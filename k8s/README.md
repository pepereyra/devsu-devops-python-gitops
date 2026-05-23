# Kubernetes Deployment

This directory contains the Kubernetes manifests used to deploy the application using a GitOps-oriented structure with Kustomize.

---

# Structure

```text
k8s/
├── base/
│   ├── namespace.yaml
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── ingress.yaml
│   ├── hpa.yaml
│   ├── secret.example.yaml
│   └── kustomization.yaml
│
└── overlays/
    ├── dev/
    │   └── kustomization.yaml
    │
    └── prod/
        └── kustomization.yaml
```

---

# Base Resources

The `base/` directory contains reusable Kubernetes manifests shared across environments.

Included resources:

- Namespace
- ConfigMap
- Deployment
- Service
- Ingress
- HorizontalPodAutoscaler
- Secret template

---

# Overlays

The `overlays/` directory contains environment-specific customizations.

## Dev Overlay

Current characteristics:

- 2 replicas
- development-oriented configuration
- automatic image updates from CI/CD pipeline

## Prod Overlay

Production-oriented configuration:

- prepared for immutable image tags
- intended for controlled promotion workflows

---

# Deployment

## Apply Dev Environment

```bash
kubectl apply -k k8s/overlays/dev
```

## Apply Prod Environment

```bash
kubectl apply -k k8s/overlays/prod
```

---

# Validate Resources

```bash
kubectl get all -n devsu-demo
```

---

# Health Checks

## Liveness Probe

```text
/api/health/live/
```

Used to validate that the application process is alive.

## Readiness Probe

```text
/api/health/ready/
```

Used to validate that the application is ready to receive traffic and that required database tables exist.

---

# Horizontal Pod Autoscaler

The deployment includes an HPA configuration:

```text
Minimum replicas: 2
Maximum replicas: 5
CPU target: 70%
```

Validate HPA:

```bash
kubectl get hpa -n devsu-demo
```

---

# Public Access

The application can be exposed publicly using:

```text
Service type: LoadBalancer
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

Example:

```bash
kubectl -n devsu-demo create secret generic devsu-devops-python-secret \
  --from-literal=DJANGO_SECRET_KEY='change-me'
```

The real secret values are intentionally excluded from Git.

---

# GitOps Workflow

Container images are built and published from the application repository.

The GitOps repository receives automatic image tag updates from the CI/CD pipeline.

Workflow summary:

```text
Application Repository
    ↓
GitHub Actions
    ↓
Build and publish image
    ↓
Update image tag in overlay
    ↓
Kubernetes deployment
```
