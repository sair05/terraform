# AWS Cloud Infrastructure Automation (Terraform)

---

## 🏗️ Overall Architecture
The projects in this repository are designed to work together as a layered "Cloud Stack." Each layer follows the principle of **Least Privilege** and **High Availability (HA)**.



---

## 📂 Project Modules

### 1. Networking Layer (VPC)
**Location:** `/vpc`
A custom-built Virtual Private Cloud designed for multi-tier applications.
* **Multi-AZ Deployment:** Subnets are distributed across two Availability Zones for fault tolerance.
* **Subnet Isolation:** * **Public Subnets:** Hosted with an Internet Gateway (IGW) for web-facing resources.
    * **Private Subnets:** Isolated from the public internet for Databases and Backend APIs.
* **NAT Gateway:** Configured to allow private instances to reach the internet for security patches while blocking inbound threats.
* **Security Groups:** "Default Deny" posture, explicitly allowing only Port 80 (HTTP) traffic.

### 2. Compute Layer (EC2)
**Location:** `/ec2`
Reusable modules for launching virtual servers with intelligent automation.
* **Dynamic AMI Lookup:** Uses Terraform Data Sources to automatically fetch the latest Amazon Linux 2023 image.
* **Compatibility Engineering:** Solved architecture mismatches (`x86_64` vs `arm64`) and boot-mode errors (UEFI vs BIOS) to ensure Free Tier (`t2.micro`) stability.
* **Lifecycle Management:** Implemented `prevent_destroy` hooks to protect critical compute resources.

### 3. Container Orchestration (EKS) - "The Scratch Build"
**Location:** `/eks`
A manual deployment of Elastic Kubernetes Service without using high-level modules to demonstrate deep infrastructure knowledge.
* **IAM Architecture:** * **Cluster Role:** Custom permissions for the Kubernetes Control Plane.
    * **Node Role:** Scoped permissions for Worker Nodes (ECR ReadOnly, CNI, and WorkerNode policies).
* **Managed Node Groups:** Scaling-enabled worker nodes using `t3.medium` instances for production-grade performance.
* **Control Plane Integration:** Securely mapped to the private subnets of the VPC module.

### 4. Storage & State (S3)
**Location:** `/s3`
Reliable object storage for application assets and Terraform backend state.
* **Security:** IAM policy-driven access controls.
* **Resiliency:** Versioning enabled to track changes and prevent accidental data loss.

---

## 🛠️ Technical Challenges & Solutions

| Challenge | Root Cause | Solution Implemented |
| :--- | :--- | :--- |
| **InvalidAMIID.NotFound** | Region-specific AMI IDs | Switched to dynamic `aws_ami` Data Sources with region-agnostic filters. |
| **UEFI Boot Error** | `t2.micro` lacks Nitro support | Forced `x86_64` architecture and BIOS-compatible image filters in Terraform. |
| **Architecture Mismatch** | ARM64 vs x86_64 conflict | Added strict `architecture` filtering to the AMI search block. |
| **Network Isolation** | Private nodes lacked updates | Deployed a **NAT Gateway** and updated Private Route Tables for outbound-only flow. |

---

## 🚀 Deployment Guide

### Prerequisites
* AWS CLI (configured with `aws configure`)
* Terraform CLI (v1.0.0+)
* SSH Key Pair for EC2 access

### Commands
```bash
# 1. Initialize the directory and download providers
terraform init

# 2. Review the infrastructure changes
terraform plan

# 3. Deploy the resources
terraform apply -auto-approve

# 4. Clean up (Cost Management)
terraform destroy -auto-approve

## 📖 How to Use
1. Clone the repository: `git clone https://github.com/sair05/terraform.git`
2. Navigate to a project folder: `cd vpc`
3. Initialize: `terraform init`
4. Plan changes: `terraform plan`
5. Apply: `terraform apply`
