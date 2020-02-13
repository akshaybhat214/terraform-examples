resource "aws_secretsmanager_secret" "rds-secretsmanager" {
  //If the secret name is not provided, generate one from the variables
  name = "${var.secret_name != "" ? var.secret_name : join("-", list(var.product, var.environment, "rds", "password"))}"
  recovery_window_in_days = 7

  tags = {
    Product     = var.product
    Environment = var.environment
  }
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  secret_id     = "${aws_secretsmanager_secret.rds-secretsmanager.id}"
  secret_string = "${random_string.rds-secret.result}"
}

resource "random_string" "rds-secret" {
  length           = "12"
  number           = true
  upper            = true
  lower            = true
  special          = false
}

output "secret_name" {
  value = "${aws_secretsmanager_secret.rds-secretsmanager.name}"
}