terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

module "api_gateway" {
    source = "../"

    region          = "us-west-2"
    api_name        = "Debug API"
    api_description = "A faux API just to test out the Terraform module"
    domain_name     = "debug.transparent.engineering"
    certificate_arn = "arn:aws:acm:us-east-1:037083514056:certificate/6e19dd75-e90d-4a83-a05e-2dc4bb171b4d"
    hosted_zone_id  = "Z182ME1672NUSH"
}

output "api_gateway_id" {
    value = "${module.api_gateway.api_gateway_id}"
}

output "api_gateway_root_resource_id" {
    value = "${module.api_gateway.api_gateway_root_resource_id}"
}
