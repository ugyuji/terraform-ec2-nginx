# ------------------------------
# Terraform Configuration
# ------------------------------
terraform {
  required_version = ">=1.1.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">3.0"
    }
  }
}

# ------------------------------
# Provider
# ------------------------------
provider "aws" {
  region  = var.region
  profile = var.profile
}

# ------------------------------
# Module
# ------------------------------
module "ec2" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  app_name      = var.app_name
}

# ------------------------------
# Variables
# ------------------------------
variable "region" {
  type = string
}

variable "profile" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "app_name" {
  type = string
}

# ------------------------------
# Outputs
# ------------------------------
output "instance_id" {
  value = module.ec2.instance_id
}
