resource "aws_s3_bucket" "example" {
  bucket = "iac-hello-world-${terraform.workspace}-my-tf-test-bucket"
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.example.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.example.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.example.arn
    events              = ["s3:ObjectCreated:*"]  
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}