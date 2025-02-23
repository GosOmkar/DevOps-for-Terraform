# Creating an AWS EC2 Instance Using Terraform

This guide walks you through the process of setting up an AWS EC2 instance using Terraform. You will create a key pair, default VPC, security group, and EC2 instance step by step.

## Prerequisites
Before starting, make sure you have the following:

### 1. Create an AWS IAM User with Administrator Access
- Go to the **AWS Management Console**.
- Navigate to **IAM (Identity & Access Management) → Users → Create a User**.
- Assign **AdministratorAccess** permissions to the user.
- Generate an **Access Key ID** and **Secret Access Key** (you’ll need these later).
- **Reference:** [AWS IAM Users Guide](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html)

### 2. Install and Configure AWS CLI
- Download and install **AWS CLI**: [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Verify installation:
  ```sh
  aws --version
  ```
- Configure AWS CLI to store credentials:
  ```sh
  aws configure
  ```
  Enter the following when prompted:
  - **Access Key ID**
  - **Secret Access Key**
  - **Default AWS Region** (use `eu-west-1`)
  - **Output format** (keep it as `json` or leave blank)

### 3. Install Terraform
- Download and install **Terraform**: [Terraform Installation Guide](https://developer.hashicorp.com/terraform/docs)
- Verify installation:
  ```sh
  terraform -v
  ```

## Step 1: Set Up the AWS Provider in Terraform
Terraform requires a provider to interact with AWS services. Create a new file named `provider.tf` and add the following code:

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}
```

## Step 2: Create an EC2 Key Pair
Before launching an EC2 instance, generate an SSH key pair:

```sh
ssh-keygen -t rsa -b 4096 -f terrademo-key
```

This will create:
- `terrademo-key.pub` → Public Key
- `terrademo-key` → Private Key (**Keep this safe; do not share it**)

Create an `aws_key_pair` resource in Terraform:

```hcl
resource "aws_key_pair" "my-key" {
    key_name   = "terraec2-key"
    public_key = file("terrademo-key.pub")
}
```

## Step 3: Create a Default VPC
AWS provides a default VPC in each region. Reference it in Terraform:

```hcl
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default vpc"
  }
}
```

## Step 4: Create a Security Group
Define a security group to control inbound and outbound traffic:

```hcl
resource "aws_security_group" "my_security_gp" {
    name        = "my-extra-sec"
    description = "This is a special SG created by me"
    vpc_id      = aws_default_vpc.default.id

    ingress {
        description = "Allow SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "Allow all outgoing traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
```

## Step 5: Create an EC2 Instance
Define an **AWS EC2 instance** in Terraform:

```hcl
resource "aws_instance" "my_instance" {
    instance_type   = "t2.micro"
    ami            = "ami-03fd334507439f4d1"  # Amazon Linux AMI
    key_name       = aws_key_pair.my-key.key_name
    security_groups = [aws_security_group.my_security_gp.name]

    root_block_device {
      volume_size = 8
      volume_type = "gp3"
    }

    tags = {
      Name = "tera-ec2-server"
    }
}
```

## Step 6: Initialize and Apply Terraform
Navigate to the folder where your Terraform files are saved and run:

1️⃣ Initialize Terraform:
```sh
terraform init
```

2️⃣ Check the Terraform Plan:
```sh
terraform plan
```

3️⃣ Apply Terraform to Create the EC2 Instance:
```sh
terraform apply
```
Terraform will prompt for confirmation. Type `yes` and press **Enter**.

## Step 7: Verify the EC2 Instance in AWS
Once Terraform applies the configuration successfully, go to the **AWS EC2 Console**:
👉 [AWS EC2 Console](https://console.aws.amazon.com/ec2)

Check if the instance **tera-ec2-server** is running.

## Step 8: Connect to the EC2 Instance (Optional)
To connect via SSH, use the private key:

```sh
ssh -i terrademo-key ec2-user@<INSTANCE_PUBLIC_IP>
```

Find the **Public IP** of your instance in the AWS console.

## Step 9: Destroy the EC2 Instance (Optional)
If you want to remove the EC2 instance, run:

```sh
terraform destroy
```
Terraform will ask for confirmation. Type `yes` and press **Enter**.

## Conclusion
You have successfully created an **AWS EC2 instance using Terraform**! This process included:

✅ Setting up AWS credentials.
✅ Configuring Terraform with the AWS provider.
✅ Writing Terraform code for EC2.
✅ Applying Terraform to provision resources.
✅ Verifying the EC2 instance in AWS.

For more details, refer to:
- [Terraform AWS Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Official Guide](https://developer.hashicorp.com/terraform/docs)

Happy Terraforming! 🚀

