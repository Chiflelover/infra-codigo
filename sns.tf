# Tema SNS para publicar notificaciones
resource "aws_sns_topic" "notifications" {
  name = "notifications-topic-${terraform.workspace}"
}

# Suscripción de SNS a SQS
resource "aws_sns_topic_subscription" "sqs_subscription" {
  topic_arn = aws_sns_topic.notifications.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.messages_queue.arn
}
