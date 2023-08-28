
data "aws_instance" "hga-ec2-tf-test" {

}

resource "aws_sns_topic" "hga-lamp-sns" {
  name = "hga-lamp-sns"

}
resource "aws_sns_topic_subscription" "hga-lamp-sns-sub" {
  topic_arn = "${aws_sns_topic.hga-lamp-sns.arn}"
  protocol  = "email"
  endpoint  = "adarsha.hg@hitachivantara.com"
}

resource "aws_cloudwatch_metric_alarm" "hga-lamp-cw-alb-alaram" {
  alarm_name          = "hga-lamp-cw-alb-alaram"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = 60
  statistic           = "Average"
  threshold           = length(data.aws_instance.hga-ec2-tf-test)
  alarm_description   = "Number of healthy nodes in Target Group"
  actions_enabled     = "true"
  alarm_actions       = [aws_sns_topic.hga-lamp-sns.arn]
  ok_actions          = [aws_sns_topic.hga-lamp-sns.arn]
  dimensions = {
    TargetGroup  = aws_lb_target_group.hga-lamp-alb-trg.arn
    LoadBalancer = aws_alb.hgalampalb.arn
  }
}
