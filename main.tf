provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "ce5-group6-vpc-tf-state-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}


resource "aws_s3_bucket_versioning" "versioning" {
  bucket = "ce5-group6-vpc-tf-state-bucket"
  versioning_configuration {
    status = "Enabled"
  }
}


data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"
  name    = "ce5-group6-vpc-02"
  cidr    = "172.16.0.0/16"
  azs = data.aws_availability_zones.available.names

  #  ref: https://chatgpt.com/share/9d1a3b37-e074-4d9c-af23-aad912367a77
  private_subnets = ["172.16.7.0/24", "172.16.8.0/24", "172.16.9.0/24"]
  public_subnets = ["172.16.10.0/24", "172.16.11.0/24", "172.16.12.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/ce5-group6-eks-cluster" = "shared"
    "kubernetes.io/role/elb"                       = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/ce5-group6-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"              = "1"
  }
}