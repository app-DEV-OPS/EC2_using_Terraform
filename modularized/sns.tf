resource "aws_sns_topic" "hga-lamp-sns" {
  name = "hga-lamp-sns"
  
}
resource "aws_sns_topic_subscription" "hga-lamp-sns-sub" {
  topic_arn = "${aws_sns_topic.hga-lamp-sns.arn}"
  protocol  = "email"
  endpoint  = "adarsha.hg@hitachivantara.com"
}
