terraform {
    required_version = ">= 0.10.7"
    backend "s3" {}
}

provider "aws" {
    region     = "${var.region}"
}

resource "aws_api_gateway_rest_api" "rest_api" {
    name        = "${var.api_name}"
    description = "${var.api_description}"
}
