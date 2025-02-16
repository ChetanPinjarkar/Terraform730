# S3 Bucket to Store Lambda Code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "chetankis3bucket"
  acl           = "private"
  force_destroy = true
  tags = {
    Name = "LambdaBucket"
  }
}

# Upload Python Lambda Code to S3
resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip"
  #etag   = filemd5("lambda_function.zip")
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach Policy to IAM Role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role = aws_iam_role.lambda_exec_role.name
  #policy_arn = "arn:aws:iam::474668424761:policy/service-role/AWSLambdaBasicExecutionRole-880edb6b-97bb-4fdd-90c0-d369fa092e71"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Lambda Funcation
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "lambda_funcation.lambda_handler"
  s3_bucket     = aws_s3_bucket.lambda_bucket.id
  s3_key        = aws_s3_object.lambda_code.key
  timeout       = 100
  memory_size   = 128

  environment {
    variables = {
      ENV_VAR_KEY = "ENV_VAR_VALUE" # Example of Environment Variable
    }
  }
  tags = {
    Name = "MyLambdaFuncation"
  }
}