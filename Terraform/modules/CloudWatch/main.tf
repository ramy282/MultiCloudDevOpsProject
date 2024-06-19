resource "aws_sns_topic" "sns_topic" {
  name = "name"
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
  alarm_name          = "Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  statistic           = "Average"
  metric_name         = "Utilization"
  period              = var.time
  threshold           = "70"
  alarm_description   = "Request error rate has exceeded 70% for 2 consecutive periods"
  actions_enabled     = true
  namespace           = "AWS/EC2"

  dimensions = {
    InstanceId = var.EC2
  }

  alarm_actions = [aws_sns_topic.sns_topic.arn]
}


resource "aws_iam_policy" "policy" {
  name        = "CloudWatchPolicy"
  description = "CloudWatch IAM policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = [
        "SNS:Publish"
      ],
      Effect   = "Allow",
      Resource = aws_sns_topic.sns_topic.arn
    }]
  })
}

resource "aws_sns_topic_subscription" "sns-target" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.Email
}

resource "aws_iam_role" "cloudwatch_role" {
  name = "CloudTestRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "cloudwatch.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch_polcicy_attach" {
  policy_arn = aws_iam_policy.policy.arn
  role       = aws_iam_role.cloudwatch_role.name
}

resource "aws_cloudwatch_log_group" "logs" {
  name              = "/var/log/messages"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "stream" {
  name           = "stream"
  log_group_name = aws_cloudwatch_log_group.logs.name
}
