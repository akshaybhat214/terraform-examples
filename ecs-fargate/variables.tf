variable "region" {
  default     = "us-west-1"
}

variable "fargate_cpu" {
  default     = "1024"
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
}

variable "fargate_memory" {
  default     = "2048"
  description = "Fargate instance memory to provision (in MiB)"
}

variable "environment" {
  default     = "dev"
}

variable "owner" {
  default = "team@company.com"
}

variable "product" {
  default = "product-name"
}

variable "service" {
  default = "service-name"
}

variable "subnet_1" {
  default = "subnet-aaa00000e"
}

variable "subnet_2" {
  default = "subnet-aaa00001e"
}

variable "release_version" {
  default = "1.0"
}

variable "max_ecs_task_count" {
  default = 3
  type = number
}

variable "ecs_role_name" {
  default = "DummyEcsTaskRole"
  description = "AWS role for ECS task execution"
}

variable "ecs_auto_scale_role_name" {
  default = "DummyEcsAutoScaleRole"
  description = "AWS role for ECS auto scale"
}

variable "app_image" {
  default     = "dummy-app:latest"
  description = "Docker image to run in the ECS cluster"
}

variable "app_port" {
  default     = 8080
}

variable "app_count" {
  default     = 1
  description = "Number of containers to run"
}

variable "az_count" {
  default     = "2"
  description = "Number of AZs to cover in a given region"
}

variable "health_check_path" {
  default = "/"
}