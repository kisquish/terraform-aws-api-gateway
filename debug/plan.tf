terraform {
    required_version = ">= 0.10.6"
    backend "s3" {}
}

data "terraform_remote_state" "vpc" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/networking/vpc/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "security-groups" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/networking/security-groups/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "bastion" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/compute/bastion/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "iam" {
    backend = "s3"
    config {
        bucket = "transparent-test-terraform-state"
        key    = "us-west-2/debug/security/iam/terraform.tfstate"
        region = "us-east-1"
    }
}

module "api_gateway" {
    source = "../"

    region                      = "us-west-2"
    api_name                    = "Debug API"
    api_description             = "A faux API just to test out the Terraform module"    
}
