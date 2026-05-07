# 🏗️ Roboshop — AWS Production Infrastructure

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

## 🎯 Project Overview
Production-grade AWS infrastructure for Roboshop e-commerce 
microservices application. Built using modular Terraform — 
covering complete networking, security, databases, load balancing, 
VPN, SSL/TLS, and application components.

## 🏗️ Architecture
Internet
│
▼
CloudFront (CDN)
│
▼
ACM (SSL/TLS Certificate)
│
▼
Frontend ALB (Public)
│
▼
┌─────────────────────────────────┐
│           VPC                   │
│  ┌──────────────────────────┐   │
│  │     Public Subnet        │   │
│  │  Bastion Host | VPN      │   │
│  └──────────────────────────┘   │
│  ┌──────────────────────────┐   │
│  │     Private Subnet       │   │
│  │  Backend ALB             │   │
│  │  Catalogue | User        │   │
│  │  MongoDB | MySQL         │   │
│  │  Redis | RabbitMQ        │   │
│  └──────────────────────────┘   │
└─────────────────────────────────┘
## 📁 Infrastructure Components

| Module | Description |
|---|---|
| `00-vpc` | VPC, Subnets, IGW, NAT Gateway, Route Tables |
| `001-sg` | Security Groups for all components |
| `20-bastion` | Bastion Host for secure SSH access |
| `30-vpn` | OpenVPN server for private network access |
| `40-databases` | MongoDB, MySQL, Redis, RabbitMQ setup |
| `50-backend-alb` | Internal ALB for backend microservices |
| `60-acm` | AWS Certificate Manager for SSL/TLS |
| `60-catalogue` | Catalogue microservice infrastructure |
| `70-frontend-alb` | Public ALB for frontend traffic |
| `80-user` | User microservice infrastructure |
| `90-components` | Remaining Roboshop components |

## 🛠️ Tech Stack
- **IaC:** Terraform
- **Cloud:** AWS
- **Networking:** VPC, Subnets, IGW, NAT, Route Tables
- **Security:** Security Groups, NACLs, IAM, Bastion Host
- **Load Balancing:** ALB (Frontend + Backend)
- **SSL/TLS:** AWS Certificate Manager (ACM)
- **VPN:** OpenVPN
- **Databases:** MongoDB, MySQL, Redis, RabbitMQ
- **OS:** Linux (RHEL, Amazon Linux)

## ✅ Features Implemented
- Multi-tier VPC with public and private subnets
- Bastion Host for secure SSH access to private resources
- OpenVPN for secure remote network access
- Separate Security Groups per component — least privilege
- Internal ALB for backend service routing
- Public ALB with SSL termination for frontend
- ACM managed SSL/TLS certificates
- Complete database infrastructure — MongoDB, MySQL, Redis, RabbitMQ
- Modular Terraform — each component independently deployable
- Remote state management using S3

## 🗄️ Remote State Management using AWS S3 with DynamoDB state locking

Each component has isolated state in AWS S3:

| Component | S3 Key |
|---|---|
| VPC | `roboshop-dev-vpc/terraform.tfstate` |
| Security Groups | `roboshop-dev-sg/terraform.tfstate` |
| Bastion Host | `roboshop-dev-bastion/terraform.tfstate` |
| VPN | `roboshop-dev-vpn/terraform.tfstate` |
| Databases | `roboshop-dev-db/terraform.tfstate` |
| Backend ALB | `roboshop-dev-backend_alb/terraform.tfstate` |
| ACM | `roboshop-dev-acm/terraform.tfstate` |
| Frontend ALB | `roboshop-dev-frontend_alb/terraform.tfstate` |
| EKS Cluster | `roboshop-dev-eks/terraform.tfstate` |
| CI/CD | `roboshop-dev-cicd/terraform.tfstate` |
| App Components | `roboshop-dev-catalogue/terraform.tfstate` |

### Benefits of Per-Component State
- ✅ Independent component updates
- ✅ No state file conflicts in team environment
- ✅ Faster Terraform operations per component
- ✅ Isolated blast radius on state corruption
- ✅ Separate Dev and Prod state buckets

### State Configuration Example
```hcl
terraform {
  backend "s3" {
    bucket = "84devops-dev"
    key    = "roboshop-dev-vpc/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "84devops"    # State locking
  }
}
```

## 🌍 Multi-Environment Setup

| Environment | S3 Bucket | Status |
|---|---|---|
| Development | `84devops-dev` | ✅ Active |
| Production | `84devops-prod` | ✅ Active |

## 🚀 How to Deploy

### Prerequisites
```bash
# Install Terraform
wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
unzip terraform_1.5.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# Configure AWS credentials
aws configure
```

### Deployment Order
```bash
# 1. Deploy VPC first
cd 00-vpc
terraform init
terraform plan
terraform apply

# 2. Deploy Security Groups
cd ../001-sg
terraform init && terraform apply

# 3. Deploy Bastion Host
cd ../20-bastion
terraform init && terraform apply

# 4. Deploy VPN
cd ../30-vpn
terraform init && terraform apply

# 5. Deploy Databases
cd ../40-databases
terraform init && terraform apply

# 6. Deploy Backend ALB
cd ../50-backend-alb
terraform init && terraform apply

# 7. Deploy ACM Certificate
cd ../60-acm
terraform init && terraform apply

# 8. Deploy Application Components
cd ../60-catalogue && terraform init && terraform apply
cd ../80-user && terraform init && terraform apply
cd ../90-components && terraform init && terraform apply

# 9. Deploy Frontend ALB
cd ../70-frontend_alb
terraform init && terraform apply
```

## 🔧 Key Design Decisions
| Decision | Reason |
|---|---|
| Modular Terraform | Each component independently manageable |
| Bastion Host | Secure access to private subnet resources |
| OpenVPN | Developer access to private network |
| Separate SGs per component | Least privilege security model |
| Internal ALB for backend | Microservices not exposed to internet |
| ACM for SSL | Managed certificate rotation |

## 🔒 Security Features
- All databases in private subnets — not internet accessible
- Bastion Host is the only public SSH entry point
- Security Groups allow only required ports per component
- IAM roles follow least privilege principle
- SSL/TLS termination at ALB level

## 📸 Screenshots
> Add screenshots of AWS Console showing deployed infrastructure

## 🔗 Related Projects
- [Roboshop Docker](https://github.com/NaveenKumar-dev5351/roboshop-docker)
- [Roboshop Ansible](https://github.com/NaveenKumar-dev5351/ansible-roboshop)
- [Roboshop Shell](https://github.com/NaveenKumar-dev5351/shell-roboshop)

## 👨‍💻 Author
**Naveen Kumar Lingampelly**
DevOps Engineer | [LinkedIn](https://linkedin.com/in/naveenlingampelli) | [GitHub](https://github.com/NaveenKumar-dev5351)