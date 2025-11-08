# platform-infra

Infrastructure-as-Code project for provisioning and bootstrapping a complete Kubernetes platform using **Terraform** and **GitOps tooling**.

This repository demonstrates a modern, cloud-agnostic platform setup that combines:
- **Terraform** for declarative infrastructure provisioning  
- **Kubernetes** as the compute control plane  
- **Argo CD** for GitOps-based continuous delivery  
- **Ingress NGINX**, **Cert-Manager**, and **Sealed Secrets** as core cluster services

---

## 🔧 Repository Structure

```
platform-infra/
├── terraform/      # Terraform configuration for core infrastructure
│ ├── backend.tf    # Remote backend configuration (e.g., Azure/AWS/GCP)
│ ├── main.tf       # Main infrastructure definitions
│ ├── variables.tf  # Input variables and defaults
│ └── versions.tf   # Provider and Terraform version constraints
│
└── tools/          # GitOps-managed bootstrap tools
├── argocd/         # Argo CD installation and configuration
│ ├── argocd.yaml
│ └── configs/
│ └── argo-ingress.yaml
│
├── ingress-nginx/  # NGINX Ingress Controller manifests
│ └── ingress-nginx.yaml
│
├── cert-issuer/    # Cert-Manager issuers for TLS certificates
│ ├── clusterissuer-dns01.yaml
│ └── wild.yaml
│
└── sealed-secrets/ # Sealed Secrets controller for secure secret management
└── controller.yaml
```

---

## 🌍 Overview

This repository provisions a Kubernetes cluster and bootstraps essential GitOps tooling to manage workloads declaratively.

1. **Terraform phase** – creates all underlying infrastructure (e.g., networking, managed Kubernetes, IAM/OIDC configuration).
2. **Bootstrap phase** – deploys Argo CD and core cluster tools.
3. **GitOps phase** – Argo CD connects to an external “GitOps” repository to continuously reconcile desired state.

---

## ⚙️ Terraform Usage

```bash
cd terraform

# Initialize backend and providers
terraform init

# Validate configuration
terraform validate

# Review planned changes
terraform plan -var-file="env/dev.tfvars"

# Apply infrastructure
terraform apply -var-file="env/dev.tfvars"
```

Typical resources (depending on provider):
- Kubernetes cluster (AKS / EKS / GKE)
- Networking, storage classes, and IAM roles
- Bootstrap namespace and Argo CD manifests

---
## 🚀 Bootstrapping GitOps Tools

Once the cluster is provisioned:
```bash
# Connect to the new cluster
kubectl config use-context <cluster-name>

# Apply core tools
kubectl apply -k tools/argocd/
kubectl apply -f tools/ingress-nginx/ingress-nginx.yaml
kubectl apply -f tools/cert-issuer/
kubectl apply -f tools/sealed-secrets/controller.yaml
```

These manifests can later be managed by Argo CD itself (self-management pattern).

---
## 🧩 Components
| Component      | Purpose                                                |
| -------------- | ------------------------------------------------------ |
| Argo CD        | GitOps controller for declarative application delivery |
| Ingress NGINX  | Ingress controller for routing HTTP/S traffic          |
| Cert-Manager   | Automated certificate management using DNS-01 or ACME  |
| Sealed Secrets | Secure encryption of Kubernetes secrets within Git     |

---
Author: Stefan Filkov
Purpose: Demonstration of Terraform + Kubernetes + Argo CD + GitOps automation patterns.