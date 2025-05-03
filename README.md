# DevSecOps Project: CI/CD Pipeline on EKS with Terraform, Jenkins, ArgoCD

## Overview

This project provisions and deploys a secure, production-grade infrastructure and CI/CD pipeline on AWS using the following tools:

* Terraform for infrastructure provisioning
* Jenkins for Continuous Integration
* ArgoCD + Argo Image Updater for Continuous Deployment (GitOps)
* External Secrets Operator for secure secrets management
* Helm for Kubernetes resource management
* NodeJS App deployed alongside MySQL and Redis

---

## 🌐 Architecture Diagram

![ItI-GP-DevSecOps](https://github.com/user-attachments/assets/fe809da2-403e-40fe-87a1-bd179a09e7cf)


---

## 🌐 Project Structure

```
├── terraform/                # Modular Terraform code for VPC, EKS, IAM, Helm Relase files (for jenkins,argocd setuo).
├── jenkins/                 # Jenkins pipeline scripts
├── argocd/                  # ArgoCD App manifests, image updater config
├── external-secrets/        # ESO manifests and configuration
├── manifests/               # App manifests (Helm)
├── scripts/                 # Script to provision and deploy infrastructure
├── README.md                # Project documentation
```

---

## Setup Instructions

### 🚀 Prerequisites

* AWS CLI configured with sufficient permissions
* Docker installed
* Terraform installed
* kubectl configured
* Helm v3


### 🔨 One-Step Provisioning and Deployment

> A script is included to provision infrastructure and deploy the full DevSecOps stack.

```bash
cd scripts
chmod +x setup.sh
./setup.sh
```

This script will:

1. Initialize and apply Terraform code to provision:

   * VPC (3 AZs, public/private subnets)
   * EKS cluster and node groups in private subnets
   * NAT Gateway, Internet Gateway, Route Tables
   * IAM roles and policies
2. Install Jenkins and ArgoCD into the EKS cluster via Helm
3. Apply ArgoCD Application manifest
4. Install External Secrets Operator and sync secrets from AWS Secrets Manager

---

## CI/CD Pipeline Flow

## 🌐 Architecture Diagram

![devsecops](https://github.com/user-attachments/assets/b77ac261-eef2-4605-892c-7541c298199e)


### CI with Jenkins

* Jenkins installed in EKS via Helm
* Triggered by GitHub push
* Jenkinsfile steps:

  * Clone NodeJS app repo
  * Run static analysis (SonarQube, Trivy, OWASP DC)
  * Build and tag Docker image
  * Push image to Amazon ECR

### CD with ArgoCD + Argo Image Updater

* ArgoCD syncs manifests from Git repository
* Manifests define the deployment of NodeJS, MySQL, and Redis
* Argo Image Updater watches the ECR repo:

  * Detects new image tags
  * Auto-updates tags in Git repo
  * Triggers ArgoCD sync (GitOps)

---

## 🔐 Secrets Management

* External Secrets Operator pulls secrets from AWS Secrets Manager
* Automatically creates Kubernetes secrets
* Used for MySQL, Redis credentials

---

## 🌐 Application Stack

* NodeJS Web App from [repo](https://github.com/mahmoud254/jenkins_nodejs_example.git)
* MySQL database as a StatefulSet
* Redis pod for caching
* App configuration externalized using `configMap.yaml` and `secret.yaml`
* Connected via environment variables

---

## 🌐 Ingress and TLS 

* NGINX Ingress Controller
* Cert-Manager using DNS
* HTTPS access to NodeJS app

---

