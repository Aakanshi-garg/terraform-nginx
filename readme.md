
# Deploy nginx web server using terraform

This project uses Terraform to deploy a simple web server Nginx on an AWS EC2 instance. It automatically installs the web server using a user data script and exposes it via a public IP on port 80. Ideal for beginners learning cloud infrastructure automation.

## 🚀 Requirements

- Terraform ≥ 1.0
- AWS CLI configured (`aws configure`)
- An AWS account with EC2 access

## 📌 Features

- Launches an EC2 instance with Ubuntu
- Installs and starts Nginx using user data
- Allows HTTP (port 80) traffic via a Security Group
- Outputs the instance's public IP for access

## Step 1: AWS Provider Configuration
This project begins by initializing Terraform with the AWS provider. The configuration in `terraform.tf` sets up the backend to use AWS services and downloads the necessary provider plugin.

📄 [Click here to view the terraform.tf file](./terraform.tf)

## Step 2: Define the AWS Provider Region

The AWS region is configured in the [`provider.tf`](./provider.tf) file. This tells Terraform which AWS region to deploy your infrastructure to.

## Step 3: Launch an EC2 Instance with Nginx

This step provisions an EC2 instance using the configuration in [`ec2.tf`](./ec2.tf) with an Nginx web server automatically installed using a shell script.

---

### 🔑 Key Components

- **Key Pair**: Created using your own public key (`terra-us-east-2.pub`) to allow SSH access.
- **Security Group**: Allows inbound traffic on:
  - **Port 22**: For SSH access
  - **Port 80**: For HTTP (Nginx)
  - **Port 443**: For HTTPS (future support)
- **Default VPC**: Uses AWS's default VPC.
- **User Data Script**: Automatically installs and starts Nginx on boot using [`install_nginx.sh`](./install_nginx.sh).
- **Root Block Volume**: Customizable volume size and type using input variables.

---

### 📁 Files Involved

- [`ec2.tf`](./ec2.tf): Main EC2 instance configuration.
- [`install_nginx.sh`](./install_nginx.sh): Shell script for installing Nginx.
- [`terra-us-east-2.pub`](./terra-us-east-2.pub): Your generated SSH public key (not pushed to GitHub).
- [`variables.tf`](./variables.tf): All referenced variables are declared here.

---

### 📤 Output Information

After successful deployment, Terraform displays the following instance details using [`outputs.tf`](./outputs.tf):

- **Public IP**: Used to access the Nginx web server from your browser
- **Private IP**: Internal IP address within the VPC
- **Public DNS Name**: AWS DNS for accessing the instance via browser or SSH

---

## 🚀 How to Apply Terraform Configuration

Follow these steps to initialize Terraform, review the execution plan, and launch your infrastructure on AWS.

### 1. Generate SSH Key Pair (if not already)
Open a terminal and run:
```
ssh-keygen

```
This creates two files:

- terra-us-east-2 — the private key

- terra-us-east-2.pub — the public key used in Terraform

⚠️ Do not share the private key (terra-us-east-2) publicly.

### 2.Initialize Terraform
```
terraform init
```
This command downloads the required provider plugins (like AWS).

### 3. Preview the Execution Plan
```
terraform plan
```
This shows what Terraform will create, change, or destroy — without applying it.

### 4. Apply the Terraform Code
```
terraform apply
```
Type yes when prompted.

```
terraform apply -auto-approve
```
Run this command to approve automatically.

Terraform will provision the infrastructure and output values like:
- Public IP
- Private IP
- Public DNS
Example output:
```
ec2_public_ip = "3.94.118.XX"
ec2_private_ip = "172.31.34.XX"
ec2_public_dns = "ec2-3-94-118-XX.compute-1.amazonaws.com"
```
### 5. Access the Nginx Web Server
Open your browser and visit:
```
http://<ec2_public_ip>  OR  http://<ec2_public_dns>
```
You should see the Nginx Welcome Page!

### 6. Destroy Resources When Done
```
terraform destroy
```
This will remove all resources created by Terraform.
