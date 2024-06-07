# AWS VPC Creation for EKS

This project contains Terraform scripts to create a VPC in AWS for EKS.

## Prerequisites

- Terraform installed
- AWS CLI installed and configured

## Provider Configuration

The provider is configured to use the AWS region `us-east-1`.

## Terraform Backend

The state of the Terraform is stored in an S3 bucket
named `ce5-group6-vpc-tf-state-bucket`.

## Resources

- An S3 bucket with versioning enabled: `ce5-group6-vpc-tf-state-bucket`
- A VPC with the following configuration:
    - Name: `ce5-group6-vpc-02`
    - CIDR block: `172.16.0.0/16`
    - Private subnets: `172.16.7.0/24`, `172.16.8.0/24`, `172.16.9.0/24`
    - Public subnets: `172.16.10.0/24`, `172.16.11.0/24`, `172.16.12.0/24`
    - NAT gateway: Enabled
    - DNS hostnames: Enabled

## Usage

To apply the Terraform scripts, navigate to the directory containing the scripts
and run:

```bash
terraform init
terraform plan
terraform apply
```
