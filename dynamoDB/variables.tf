variable "region" {
  default = "us-west-2"
}

variable "environment" {
  default = "dev"
}

variable "project_name" {
  default = "projectName"
}

variable "product" {
  default = "yourProductName"
}

variable "hash_key" {
  default = "customerId"
}

variable "sort_key" {
  default = "timestamp"
}

variable "default_billing_mode" {
  default = "PAY_PER_REQUEST"
}

variable "default_read_capacity" {
  default = "10"
}

variable "default_write_capacity" {
  default = "10"
}