variable "region" {
    type = "string"
    description = "The AWS region to deploy into (e.g. us-east-1)"
}

variable "api_name" {
    type = "string"
    description = "Name of the API"
}

variable "api_description" {
    type = "string"
    description = "Short description about the API"
}
