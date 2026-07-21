# Prerequisites
#
- JDK 11 
- Maven 3 
- MySQL 8

# Technologies 
- Spring MVC
- Spring Security
- Spring Data JPA
- Maven
- JSP
- Tomcat
- MySQL
- Memcached
- Rabbitmq
- ElasticSearch
# Database
Here,we used Mysql DB 
sql dump file:
- /src/main/resources/db_backup.sql
- db_backup.sql file is a mysql dump file.we have to import this dump to mysql db server
- > mysql -u <user_name> -p accounts < db_backup.sql

# DevOps Implementation

## Docker
- Created multi-stage Dockerfiles for all application services.
- Used Docker Compose for local development and testing.
- Built and published Docker images to Docker Hub.

## Terraform
- Provisioned the AWS infrastructure using Infrastructure as Code (IaC).
- Created an S3 bucket with versioning and server-side encryption for Terraform state storage.
- Created a DynamoDB table for state locking.
- Provisioned the following AWS resources:
  - VPC
  - Public and Private Subnets
  - Internet Gateway
  - NAT Gateway
  - Route Tables
  - Security Groups
  - Amazon EKS Cluster

## Kubernetes
- Deployed the complete application on Amazon EKS.
- Configured Deployments, Services, Persistent Volume Claims (PVCs), and ConfigMaps.
- Used the AWS EBS CSI Driver for persistent storage.

## Ingress Controller
- Configured the AWS Load Balancer Controller (ALB Ingress Controller).
- Integrated IAM Roles for Service Accounts (IRSA) using an OIDC provider.
- Exposed the application securely over HTTPS using AWS Certificate Manager (ACM).

## Helm
- Created reusable Helm charts for the application.
- Parameterized application configuration using `values.yaml`.
- Managed Kubernetes resources through Helm releases.

## Continuous Integration (CI)
Implemented Jenkins as the CI tool using a custom Docker agent.

### Pipeline Workflow
1. Checkout the source code from GitHub.
2. Build the Maven application.
3. Build and push the Docker image to Docker Hub.
4. Update the Helm chart image tag.
5. Commit and push the updated Helm chart back to GitHub.

## Continuous Delivery (CD)
- Implemented GitOps using Argo CD.
- Argo CD continuously monitors the Git repository for changes.
- Any update to the Helm charts is automatically synchronized and deployed to the EKS cluster.