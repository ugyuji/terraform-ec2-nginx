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
  volume_size   = var.volume_size
  app_name      = var.app_name
  app_version   = var.app_version
  environment   = var.environment
  subnet_id     = module.vpc.public-subnet-a_id
}

module "vpc" {
  source                 = "./modules/vpc"
  app_name               = var.app_name
  environment            = var.environment
  vpc_cidr_block         = var.vpc_cidr_block
  subnet_cidr_block_az_a = var.subnet_cidr_block_az_a
  subnet_cidr_block_az_c = var.subnet_cidr_block_az_c
}

# ------------------------------
# Variables
# ------------------------------
variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "profile" {
  type    = string
  default = "default"
}

variable "ami_id" {
  type    = string
  default = "ami-0f9c9d9c7f9d9b9e7"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "volume_size" {
  type    = number
  default = 8
}

variable "app_name" {
  type = string
}

variable "app_version" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_cidr_block_az_a" {
  type = string
}

variable "subnet_cidr_block_az_c" {
  type = string
}

# ------------------------------
# Outputs
# ------------------------------
output "instance_id" {
  value = module.ec2.instance_id
}
