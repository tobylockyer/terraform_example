# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm

resource "aws_cloudwatch_metric_alarm" "ec2_cpu" {
  alarm_name                = "ec2_cpu"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
       InstanceId = aws_instance.web.id
     }
}

resource "aws_cloudwatch_metric_alarm" "ec2_mem" {
  alarm_name                = "ec2_mem"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "mem_used_percent"
  namespace                 = "CWAgent"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 memory utilization from CW Agent"
  insufficient_data_actions = []

  dimensions = {
       InstanceId = aws_instance.web.id
     }
}
## To enable memory monitoring we would need to run a cloudwatch-agent...