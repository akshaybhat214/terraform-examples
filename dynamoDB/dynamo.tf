resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name          = "${var.project_name}-${var.environment}"
  billing_mode  = var.default_billing_mode
  hash_key      = var.hash_key
  range_key     = var.sort_key

  //Set read/write capacity to 0 if we are using PAY_PER_REQUEST, use defaults otherwise
  read_capacity  = "${var.default_billing_mode == "PROVISIONED" ? var.default_read_capacity : 0}"
  write_capacity = "${var.default_billing_mode == "PROVISIONED" ? var.default_write_capacity : 0}"

  attribute {
    name = var.hash_key
    type = "N"
  }

  attribute {
    name = var.sort_key
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  point_in_time_recovery {
    enabled = false
  }

  tags = {
    Product     = var.product
    Environment = var.environment
  }
}