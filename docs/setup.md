# Infrasetup 

## Overview

This repository contains Terraform configuration files for deploying an Amazon EKS (Elastic Kubernetes Service) cluster and a VPC (Virtual Private Cloud) on AWS. The configuration is separated into two main files: `eks.tf` for the EKS cluster and `vpc.tf` for the VPC setup.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- An [AWS Account](https://aws.amazon.com/).
- AWS CLI installed and configured with appropriate permissions.
- IAM permissions to create EKS clusters, VPCs, subnets, and associated resources.

## Configuration Files

- **`vpc.tf`**: Contains the configuration for creating a VPC with subnets, route tables, and internet gateways.
- **`eks.tf`**: Contains the configuration for setting up an EKS cluster and node groups.
- **`backend.tf`**: stored infrastructure information using s3 as a backend.
