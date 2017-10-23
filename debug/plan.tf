terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

module "api_gateway" {
    source = "../"

    region          = "us-west-2"
    api_name        = "Debug API"
    api_description = "A faux API just to test out the Terraform module"
}

output "api_gateway_id" {
    value = "${module.api_gateway.api_gateway_id}"
}

output "api_gateway_root_resource_id" {
    value = "${module.api_gateway.api_gateway_root_resource_id}"
}
