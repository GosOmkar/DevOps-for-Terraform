Step-by-Step Guide to Creating an S3 Bucket Using Terraform
This guide explains how to create an AWS S3 bucket using Terraform in a simple and easy-to-understand way. It covers everything from setting up AWS credentials to writing Terraform code and applying it.

Prerequisites
Before starting, make sure you have:

An AWS IAM user with Administrator Access

Go to the AWS Management Console.
Navigate to IAM (Identity & Access Management) → Users → Create a User.
Give the user AdministratorAccess permissions.
Generate Access Key ID and Secret Access Key (you’ll need these later).
AWS CLI installed and configured

Download and install AWS CLI from the official AWS CLI Installation Guide.
To check if AWS CLI is installed, run:
sh
Copy
Edit
aws --version
Configure AWS CLI by running:
sh
Copy
Edit
aws configure
This will prompt you to enter:
Access Key ID
Secret Access Key
Default AWS Region (use eu-west-1)
Output format (keep it as json or leave it blank).
Terraform installed

Download and install Terraform from the official Terraform Installation Guide.
Verify installation by running:
sh
Copy
Edit
terraform -v
Step 1: Set Up the AWS Provider in Terraform
Terraform needs a provider to interact with AWS services. Create a new file named terraform_provider.tf and add this code:

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
This code tells Terraform to use the AWS provider and specifies the region where resources will be created (eu-west-1).

Step 2: Write the Terraform Code to Create an S3 Bucket
Now, create another file named awsS3.tf and add this code:

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
This code:

Creates an S3 bucket named gosom-dev-tera.
Adds tags to help identify the bucket easily.
Step 3: Initialize and Apply Terraform
Now, open a terminal and navigate to the folder where you saved the Terraform files. Run these commands one by one:

Initialize Terraform

sh
Copy
Edit
terraform init
This command downloads the required AWS provider for Terraform.

Check the Terraform Plan

sh
Copy
Edit
terraform plan
This will show what Terraform is about to create.

Apply Terraform to Create the S3 Bucket

sh
Copy
Edit
terraform apply
Terraform will ask for confirmation. Type yes and press Enter.

Step 4: Verify the S3 Bucket in AWS Console
Once Terraform applies the configuration successfully, go to the AWS S3 Console:
👉 AWS S3 Console

Check if the bucket gosom-dev-tera has been created.

Step 5: Delete the S3 Bucket (Optional)
If you want to remove the S3 bucket, run:

sh
Copy
Edit
terraform destroy
Type yes when prompted.

Conclusion
You have now successfully created an S3 bucket using Terraform! This process included:

Setting up AWS credentials
Configuring Terraform with the AWS provider
Writing Terraform code to create an S3 bucket
Applying Terraform to provision the bucket
Verifying the bucket in AWS
For more details, check out:
🔹 Terraform AWS Documentation
🔹 Terraform Official Guide

Now you’re ready to create more AWS resources using Terraform! 
