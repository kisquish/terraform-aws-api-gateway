terraform {
    required_version = ">= 0.11"
    backend "s3" {}
}

provider "aws" {
    alias = "east"
    region = "us-east-1"
}

variable "domain_name" {
    type = "string"
    default = "transparent.engineering"
}

data "aws_acm_certificate" "certificate" {
    provider = "aws.east"
    domain   = "*.${var.domain_name}"
    statuses = ["ISSUED"]
}

data "aws_route53_zone" "selected" {
    provider     = "aws.east"
    name         = "${var.domain_name}."
    private_zone = false
}

module "api_gateway" {
    source = "../"

    region          = "us-west-2"
    api_name        = "Debug Proxy"
    api_description = "A faux proxy just to test out the Terraform module"
    domain_name     = "debug.transparent.engineering"
    certificate_arn = "${data.aws_acm_certificate.certificate.arn}"
    hosted_zone_id  = "${data.aws_route53_zone.selected.zone_id}"
}

output "api_gateway_id" {
    value = "${module.api_gateway.api_gateway_id}"
}

output "api_gateway_root_resource_id" {
    value = "${module.api_gateway.api_gateway_root_resource_id}"
}

output "domain_name" {
    value = "${module.api_gateway.domain_name}"
}
