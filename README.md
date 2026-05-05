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