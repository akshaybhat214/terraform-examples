provider "aws" {
  region  = "${var.region}"
}

terraform {
  backend "s3" {
    region = "${var.region}"
    bucket = "tf-remote-state-projectName"
  }
}