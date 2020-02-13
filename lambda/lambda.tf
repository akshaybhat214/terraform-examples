resource "aws_lambda_function" "test-function" {
  filename                        = "test-lambda.zip"
  function_name                   = "test-function-${var.environment}"
  role                            = var.lambda_role
  handler                         = "lambda.lambda_handler"
  reserved_concurrent_executions  = 1
  timeout                         = 300
  runtime                         = "python3.7"
  description                     = "Prints to_print env variable"

  environment {
    variables = {
      to_print    = var.message
      subnet_id   = var.subnet_id
      environment = var.environment
    }
  }

  tags = {
    Name        = "test-lambda-${var.environment}"
    Environment = var.environment
    Product     = var.product
  }
}

resource "aws_cloudwatch_event_rule" "hourly-cron" {
  name                = "cw-rule-every-hour"
  description         = "Creates a rule that triggers target on hourly schedule"
  schedule_expression = "cron(0 * * * ? *)"
  is_enabled          = true
}

//Specifies lambda as target for cw-rule-every-hour
resource "aws_cloudwatch_event_target" "test_lambda_target" {
  rule        = aws_cloudwatch_event_rule.hourly-cron.name
  arn         = aws_lambda_function.test-function.arn
}

//Allows cloudwatch to trigger lambda
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.test-function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.hourly-cron.arn
}