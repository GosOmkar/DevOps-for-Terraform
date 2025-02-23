# Creating an S3 Bucket Using Terraform  

This guide provides a step-by-step process to create an **AWS S3 bucket** using Terraform. It covers everything from **setting up AWS credentials** to **applying Terraform configurations** in a structured way.  

---

## **Prerequisites**  

Before you begin, ensure you have completed the following:  

### **1. Create an AWS IAM User with Administrator Access**  

To interact with AWS via Terraform, you need an **IAM (Identity & Access Management) user** with the right permissions.  

- Sign in to the **[AWS Management Console](https://aws.amazon.com/console/)**.  
- Navigate to **IAM (Identity & Access Management)** → **Users** → **Create a User**.  
- Assign **AdministratorAccess** permissions to the user.  
- Generate an **Access Key ID** and **Secret Access Key** (these will be used for authentication).  

📌 **Official Documentation**: [AWS IAM Users](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)  

---

### **2. Install AWS CLI & Configure Credentials**  

The AWS Command Line Interface (CLI) allows Terraform to authenticate with AWS services.  

#### **Install AWS CLI**  
- Download and install AWS CLI: **[Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)**.  
- Verify installation:  
  ```sh
  aws --version
Configure AWS CLI
Run the following command to configure AWS CLI with your credentials:

sh
Copy
Edit
aws configure
It will prompt you to enter:

Access Key ID
Secret Access Key
Default AWS Region (e.g., eu-west-1)
Default Output Format (json or leave blank)
📌 Official Documentation: AWS CLI Configuration

3. Install Terraform
Terraform is an Infrastructure-as-Code (IaC) tool used to provision AWS resources.

Install Terraform
Download and install Terraform: Installation Guide.
Verify installation:
sh
Copy
Edit
terraform -v
📌 Official Documentation: Terraform Installation

Step 1: Define the AWS Provider
Terraform needs a provider to interact with AWS. Create a new file terraform_provider.tf and add the following code:

hcl
Copy
Edit
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
Explanation
The terraform block defines the AWS provider and its version.
The provider "aws" block configures Terraform to use AWS in the eu-west-1 region.
📌 Official Documentation: Terraform AWS Provider

Step 2: Create an S3 Bucket with Terraform
Create a new file awsS3.tf and add the following code:

hcl
Copy
Edit
resource "aws_s3_bucket" "first_bucket" {
  bucket = "gosom-dev-tera"

  tags = {
    Name        = "gosom-dev-tera"
    Environment = "Dev"
  }
}
Explanation
This block defines an S3 bucket named gosom-dev-tera.
Tags help in identifying and managing resources efficiently.
📌 Official Documentation: Terraform AWS S3 Bucket

Step 3: Initialize and Apply Terraform
1. Initialize Terraform
Terraform needs to download the required provider plugins before execution. Run:

sh
Copy
Edit
terraform init
2. Preview Terraform Changes
Before making actual changes, check the execution plan:

sh
Copy
Edit
terraform plan
3. Apply Terraform Configuration
To create the S3 bucket, apply the Terraform script:

sh
Copy
Edit
terraform apply
Type yes when prompted to confirm.

📌 Official Documentation: Terraform CLI Commands

Step 4: Verify the S3 Bucket in AWS Console
Once Terraform has applied the configuration, you can verify the bucket:

Go to the AWS S3 Console: AWS S3.
Check if the bucket gosom-dev-tera has been created.
Step 5: Destroy Terraform Resources (Optional)
If you no longer need the S3 bucket, you can remove it using:

sh
Copy
Edit
terraform destroy
Type yes when prompted to confirm.

📌 Official Documentation: Terraform Destroy

Conclusion
This guide walks through the entire process of setting up an AWS S3 bucket using Terraform, covering:

AWS IAM and CLI setup
Terraform provider configuration
S3 bucket creation
Applying and verifying Terraform scripts
By following these steps, you can automate AWS infrastructure provisioning efficiently.

For further learning, refer to:
📌 Terraform AWS Documentation
📌 Terraform Official Guide
