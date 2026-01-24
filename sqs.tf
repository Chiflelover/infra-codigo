# Cola SQS para recibir mensajes de SNS
resource "aws_sqs_queue" "messages_queue" {
  name                      = "messages-queue-${terraform.workspace}"
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
}

# Política para que SNS publique en la cola SQS
resource "aws_sqs_queue_policy" "messages_policy" {
  queue_url = aws_sqs_queue.messages_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = "sqs:SendMessage"
        Resource = aws_sqs_queue.messages_queue.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.notifications.arn
          }
        }
      }
    ]
  })
}
