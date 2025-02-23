# Step-by-Step Guide to Creating an S3 Bucket Using Terraform

This guide explains how to create an **AWS S3 bucket** using Terraform in a simple and easy-to-understand way. It covers everything from **setting up AWS credentials** to **writing Terraform code and applying it**.

---

## **Prerequisites**  
Before starting, make sure you have:

### **1. An AWS IAM User with Administrator Access**
- Go to the **[AWS Management Console](https://aws.amazon.com/console/)**.
- Navigate to **IAM (Identity & Access Management) → Users → Create a User**.
- Give the user **AdministratorAccess** permissions.
- Generate **Access Key ID** and **Secret Access Key** (you’ll need these later).

📌 **Official Documentation**: [AWS IAM Users](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)

---

### **2. Install AWS CLI and Configure Credentials**
- Download and install **AWS CLI** from the **[Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)**.
- Verify AWS CLI installation:
  ```sh
  aws --version
  ```
- Configure AWS CLI by running:
  ```sh
  aws configure
  ```
  This will prompt you to enter:
  - **Access Key ID**
  - **Secret Access Key**
  - **Default AWS Region** (use **eu-west-1**)
  - **Output format** (keep it as `json` or leave it blank).

---

### **3. Install Terraform**
- Download and install **Terraform** from the **[Official Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)**.
- Verify the installation by running:
  ```sh
  terraform -v
  ```

---

## **Step 1: Set Up the AWS Provider in Terraform**
Terraform needs a provider to interact with AWS services.

Create a new file named `terraform_provider.tf` and add the following code:

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
This code tells Terraform to:
- Use the **AWS provider** from HashiCorp.
- Set the **AWS region** to `eu-west-1`.

---

## **Step 2: Write the Terraform Code to Create an S3 Bucket**
Create another file named `awsS3.tf` and add the following code:

```hcl
resource "aws_s3_bucket" "first_bucket" {
  bucket = "gosom-dev-tera"

  tags = {
    Name        = "gosom-dev-tera"
    Environment = "Dev"
  }
}
```
This Terraform configuration:
- **Creates an S3 bucket** named `gosom-dev-tera`.
- **Adds tags** to help identify the bucket easily.

---

## **Step 3: Initialize and Apply Terraform**
Now, open a terminal and navigate to the folder where you saved the Terraform files. Run the following commands:

### **1. Initialize Terraform**
```sh
terraform init
```
This command downloads the required AWS provider for Terraform.

### **2. Check the Terraform Plan**
```sh
terraform plan
```
This will show what Terraform is about to create.

### **3. Apply Terraform to Create the S3 Bucket**
```sh
terraform apply
```
Terraform will ask for confirmation. Type `yes` and press **Enter**.

---

## **Step 4: Verify the S3 Bucket in AWS Console**
Once Terraform applies the configuration successfully, go to the **[AWS S3 Console](https://s3.console.aws.amazon.com/s3)**.

Check if the bucket **gosom-dev-tera** has been created.

---

## **Step 5: Delete the S3 Bucket (Optional)**
If you want to remove the S3 bucket, run:

```sh
terraform destroy
```
Terraform will prompt for confirmation. Type `yes` and press **Enter**.

---

## **Conclusion**
You have now successfully created an **S3 bucket** using **Terraform**! This process included:
- Setting up **AWS credentials**
- Configuring **Terraform with the AWS provider**
- Writing **Terraform code to create an S3 bucket**
- Applying **Terraform to provision the bucket**
- Verifying the bucket in **AWS Console**

For more details, check out:
- 📌 [Terraform AWS Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- 📌 [Terraform Official Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started)

Now you’re ready to create more **AWS resources** using Terraform! 🚀

