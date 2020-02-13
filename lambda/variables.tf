variable "region" {
  default = "us-west-2"
}

variable "environment" {
  default = "dev"
}

variable "product" {
  default = "productName"
}

variable "lambda_role" {
  default = "arn:aws:iam::349316668222:role/lambda_basic_execution"
}

variable "subnet_id" {
  default = "subnet-aaa00000e"
}

variable "message" {
  default = "Environment vars correctly passed"
}


