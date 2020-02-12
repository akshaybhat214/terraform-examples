variable "region" {
  default = "us-west-2"
}

variable "team" {
  default = "teamName"
}

variable "owner" {
  default = "team@company.com"
}

variable "product" {
  default = "productName"
}

variable customer_team_root {
  default = "arn:aws:iam::00000000000:root"
}

variable customer_team_emr_role{
  default = "arn:aws:iam::00000000000:role/EMRDefaultRole"
}

variable customer_team_datapipeline_resource_role {
  default = "arn:aws:iam::00000000000:role/DataPipelineDefaultResourceRole"
}

variable log_bucket {
  default = "dummy-log-bucket"
}