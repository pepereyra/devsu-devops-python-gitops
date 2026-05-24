#!/usr/bin/env bash

set -euo pipefail

NAMESPACE="dev-devsu-demo"
OVERLAY="k8s/overlays/dev"
JOB_NAME="devsu-devops-python-migrate"

echo "Enter Django secret key:"
read -s DJANGO_SECRET_KEY
echo

echo "Enter database password:"
read -s DB_PASSWORD
echo

echo "Creating namespace..."
kubectl create namespace "$NAMESPACE" --dry-run=client -o yaml | kubectl apply -f -

echo "Creating application secret..."
kubectl -n "$NAMESPACE" delete secret devsu-devops-python-secret --ignore-not-found

kubectl -n "$NAMESPACE" create secret generic devsu-devops-python-secret \
  --from-literal=DJANGO_SECRET_KEY="$DJANGO_SECRET_KEY"

echo "Creating database secret..."
kubectl -n "$NAMESPACE" delete secret devsu-devops-python-db-secret --ignore-not-found

echo "Reading Cloud SQL public IP from Terraform output..."
DB_HOST="$(cd terraform && terraform output -raw cloud_sql_public_ip)"

echo "Reading database user from Terraform output..."
DB_USER="$(cd terraform && terraform output -raw cloud_sql_user)"

kubectl -n "$NAMESPACE" create secret generic devsu-devops-python-db-secret \
  --from-literal=DB_USER="$DB_USER" \
  --from-literal=DB_PASSWORD="$DB_PASSWORD" \
  --from-literal=DB_HOST="$DB_HOST"

echo "Deleting previous migration job..."
kubectl delete job "$JOB_NAME" -n "$NAMESPACE" --ignore-not-found

echo "Applying manifests..."
kubectl apply -k "$OVERLAY"

echo "Waiting for migration job..."
kubectl wait \
  --for=condition=complete \
  "job/$JOB_NAME" \
  -n "$NAMESPACE" \
  --timeout=180s

echo "Waiting for deployment rollout..."
kubectl rollout status deployment/devsu-devops-python -n "$NAMESPACE"

echo "Deployment completed successfully."